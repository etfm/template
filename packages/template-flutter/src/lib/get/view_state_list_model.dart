import 'package:template/get/view_state_model.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';

abstract class ViewStateListModel<T> extends ViewStateModel<T> {
  /// 页面数据
  List<T> list = [];

  ///初始化设置
  initData() async {
    change(null, status: RxStatus.loading());
    await loadMore();
  }

  Future<List<T>> loadMore() async {
    try {
      List<T>? data = await loadData();
      if (data == null || data.isEmpty) {
        list.clear();
        change(null, status: RxStatus.empty());
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        change(null, status: RxStatus.success());
      }
      return data ?? [];
    } catch (e, s) {
      list.clear();
      setError(e, s);
      return [];
    }
  }

  ///加载数据
  Future<List<T>>? loadData();

  /// 获取返回数据回调
  onCompleted(List<T> data) {}
}
