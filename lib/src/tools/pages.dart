import 'package:flutter/cupertino.dart';
import 'package:ten/ten.dart';

///使用PaginatedCrud前需要补全具体函数的实现方法。根据后台的业务实现处理后返回指定的内容
interface class PaginatedRequest {
  ///参数已拼接到url
  static late Future<RGetModel> Function(String url) get;

  ///接收任何的date,返回isSuccessed;
  static late Future<RPostModel> Function(
      String url, Map<dynamic, dynamic> data) post;

  ///接收任何的date,返回isSuccessed;
  static late Future<RPutModel> Function(String url, Map<dynamic, dynamic> data)
      put;

  ///以批量删除为准，但你可以只传入key或直接传入keys 二选一，要求后台接收 List 一般为 List<String id>
  static late Future<RDeleteModel> Function(String url, {List<String>? keys})
      deleteBatch;
}

class RGetModel {
  int total;
  List list;
  RGetModel({required this.total, required this.list});
}

class RPostModel {
  bool isSuccessed;
  RPostModel({required this.isSuccessed});
}

class RPutModel {
  bool isSuccessed;
  RPutModel({required this.isSuccessed});
}

class RDeleteModel {
  bool isSuccessed;
  RDeleteModel({required this.isSuccessed});
}

enum GetMoreResult { ok, error, noMore }

interface class PaginatedDialog {
  ///预设的确认删除询问框，你可以将其覆盖。如果未覆盖，务必传入context
  static Future<bool> Function(BuildContext? context) showDeleteDialog =
      (BuildContext? context) async {
    if (context == null) throw "未覆盖，且未传入context";
    return await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("提示"),
          content: const Text("确认要进行删除操作？"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("取消"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text("删除"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  };

  ///为什么不使用Ten预设的提醒？
  ///
  ///因为预设的提醒需要传入context,每次传入又很麻烦不是吗
  static Future<void> Function() showSuccess = () async {};
  static Future<void> Function() showError = () async {};
}

/// 使用方式 ：
/// 1. 覆盖 PaginatedRequest 配置
/// 2. 覆盖 PaginatedDialog 配置
/// 3. 实例 PaginatedCrudState e.g:
/// late PaginatedCrudState useCrud = PaginatedCrudState(
///       options: PaginatedCrudOptions(
///            dataListUrl: '/app/page',
///           commonUrl: '/app',
///           queryForm: {"bizType": 0, "bizId": "5333"}),
///       onChange: (_) => {一般为更新视图操作}));
class PaginatedCrudState {
  final PaginatedCrudOptions _options;
  final void Function(List) onChange;

  ///你可以将state或者list丢入你的状态管理器中，等待onChange触发数据更新，在树中接受更新值
  PaginatedCrudOptions get state => _options;
  int get currentPage => _options.page;
  List<dynamic> get list => _options.dataList;
  bool get loading => _options.loading;

  PaginatedCrudState(
      {required PaginatedCrudOptions options,
      required Function(List<dynamic>) this.onChange})
      : _options = options {
    _init();
  }

  void _init() {
    if (_options.createdIsNeed) onRefresh();
  }

  ///下拉刷新
  Future<bool> onRefresh() async {
    if (_options.loading) return false;
    _options.loading = true;
    //如果调用失败将回溯
    final int lastPage = _options.page;
    try {
      _options.page = 1;
      String onRefreshUrl = setUrlParams(_options.dataListUrl, {
        "order": _options.order ?? "",
        "asc": "${_options.asc}",
        "page": "${_options.page}",
        "limit": "${_options.limit}",
        ...?_options.queryForm
      });
      RGetModel getResult = await PaginatedRequest.get(onRefreshUrl);
      _options.loading = false;
      _options.dataList = getResult.list;
      _options.total = getResult.total;
      onChange(_options.dataList);
      return true;
    } catch (e) {
      _options.page = lastPage;
      debugPrint(e.toString());
      return false;
    }
  }

  ///加载更多
  Future<GetMoreResult> onLoad() async {
    if (_options.loading) return GetMoreResult.error;
    if (_options.dataList.length >= _options.total) return GetMoreResult.noMore;
    _options.loading = true;
    //如果调用失败将回溯
    final int lastPage = _options.page;
    _options.page += 1;
    try {
      String onLoadUrl = setUrlParams(_options.dataListUrl, {
        "order": _options.order ?? "",
        "asc": "${_options.asc}",
        "page": "${_options.page}",
        "limit": "${_options.limit}",
        ...?_options.queryForm
      });
      RGetModel getResult = await PaginatedRequest.get(onLoadUrl);
      _options.loading = false;
      _options.dataList.addAll(getResult.list);
      _options.total = getResult.total;
      onChange(_options.dataList);
      if (_options.dataList.length >= _options.total) {
        return GetMoreResult.noMore;
      } else {
        return GetMoreResult.ok;
      }
    } catch (e) {
      _options.page = lastPage;
      debugPrint(e.toString());
      return GetMoreResult.error;
    }
  }

  /// 批量删除  删除完成后会从列表中删除根据deleteKey查找对应的项目,如果未覆盖Dialog，务必传入 BuildContext context,
  Future<bool> deleteBatchHandle({
    BuildContext? context,
    String? key,
    List<String>? keys,
    var deleteKey = "id",
  }) async {
    if (_options.deleteUrl == null && _options.commonUrl == null) {
      throw ArgumentError('deleteUrl、commonUrl 都不存在');
    }

    if (key == null && keys == null) {
      throw ArgumentError('deleteBatchHandle: key 或 keys 二选一');
    }

    if (await PaginatedDialog.showDeleteDialog(context)) {
      List<String> data = keys ?? [key!];
      await PaginatedRequest.deleteBatch(
          _options.deleteUrl ?? _options.commonUrl!,
          keys: data);
      _deleteItemForList(data);
      if (_options.autoShowDeleteResult) {
        PaginatedDialog.showSuccess();
      }
      onChange(_options.dataList);
      return true;
    }
    return false;
  }

  /// 新增
  Future<void> postHandle(Map data) async {
    if (_options.postUrl == null && _options.commonUrl == null) {
      throw ArgumentError('postUrl、commonUrl 都不存在');
    }
    RPostModel value = await PaginatedRequest.post(
        _options.postUrl ?? _options.commonUrl!, data);
    if (value.isSuccessed) {
      if (_options.autoShowPostResult) {
        PaginatedDialog.showSuccess();
      }
      onRefresh();
    } else {
      if (_options.autoShowPostResult) {
        PaginatedDialog.showError();
      }
    }
  }

  /// 修改
  Future<void> putHandle(Map data) async {
    if (_options.putUrl == null && _options.commonUrl == null) {
      throw ArgumentError('putUrl、commonUrl 都不存在');
    }
    RPutModel value = await PaginatedRequest.put(
        _options.putUrl ?? _options.commonUrl!, data);
    if (value.isSuccessed) {
      if (_options.autoShowPostResult) {
        PaginatedDialog.showSuccess();
      }
      onRefresh();
    } else {
      if (_options.autoShowPostResult) {
        PaginatedDialog.showError();
      }
    }
  }

  ///修改queryForm 的内容
  ///
  ///新内容 = {...?_options.queryForm, ...?map};
  void onSetQueryForm(Map<String, dynamic>? map) {
    _options.queryForm = {...?_options.queryForm, ...?map};
  }

  ///清空queryForm
  void reset() {
    if (!valueIsEmpty(_options.queryForm)) {
      _options.queryForm =
          _options.queryForm!.map((key, value) => MapEntry(key, null));
    }
    onRefresh();
  }

  ///根据键值将列表中的数据删除
  ///
  ///增 和 改 操作不需要此步骤因为 他们会在最前面，调用onRefresh 即可，如果不在最前面，请和后段人员协商
  ///
  ///这个函数不会触发onChange
  void _deleteItemForList(List<String> keys) {
    _options.dataList.removeWhere(
        (map) => keys.contains(map[_options.primaryKey].toString()));
  }
}

class PaginatedCrudOptions {
  /// 是否在创建类时，调用数据列表接口
  bool createdIsNeed;

  /// 数据列表 查询 Url get
  final String dataListUrl;

  /// 通用Url 增删查，优先调用专属Url
  final String? commonUrl;

  /// 删除 Url  delete
  final String? deleteUrl;

  /// 新增 Url  post
  final String? postUrl;

  /// 修改 Url put
  final String? putUrl;

  /// 主键key，用于删除场景
  String primaryKey;

  /// 查询条件
  Map<String, dynamic>? queryForm;

  /// 数据列表
  List dataList;

  /// 排序字段
  String? order;

  /// 是否升序
  bool asc;

  /// 当前页码
  int page;

  /// 每页数
  int limit;

  /// 总条数
  int total;

  ///loading
  bool loading;

  ///增删查操作自动提示操作结果
  final bool autoShowPostResult;
  final bool autoShowPutResult;
  final bool autoShowDeleteResult;

  PaginatedCrudOptions(
      {this.createdIsNeed = true,
      required this.dataListUrl,
      this.commonUrl,
      this.deleteUrl,
      this.postUrl,
      this.putUrl,
      this.primaryKey = 'id',
      this.queryForm,
      this.dataList = const [],
      this.order,
      this.asc = false,
      this.page = 1,
      this.limit = 20,
      this.total = 0,
      this.loading = false,
      this.autoShowPostResult = true,
      this.autoShowPutResult = true,
      this.autoShowDeleteResult = true});
}
