import 'package:flutter/material.dart';
import 'package:template/get/view_state_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class ViewStateRefreshListModel<T> extends ViewStateModel {
  /// 页面数据
  List<T> list = [];

  /// 分页第一页页码
  static const int pageNumFirst = 1;

  /// 分页条目数量
  static const int pageSize = 10;

  ///初始化设置
  initData() async {
    change(null, status: RxStatus.loading());
    await refresh(init: true);
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  /// 当前页码
  int _currentPageNum = pageNumFirst;

  /// 下拉刷新
  ///
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提
  Future<List<T>?> refresh({bool init = false}) async {
    try {
      _currentPageNum = pageNumFirst;
      var data = await loadData(pageNum: pageNumFirst);
      if (data.isEmpty) {
        if (list.isNotEmpty) {
          refreshController.refreshCompleted(resetFooterState: true);
        }
        list.clear();
        change(null, status: RxStatus.empty());
      } else {
        await onCompleted(data);
        list.clear();
        list.addAll(data);
        refreshController.refreshCompleted();
        // 小于分页的数量,禁止上拉加载更多
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          //防止上次上拉加载更多失败,需要重置状态
          refreshController.loadComplete();
        }
        change(null, status: RxStatus.success());
      }
      return data;
    } catch (e, s) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      if (init) list.clear();
      refreshController.refreshFailed();
      setError(e, s);
    }
  }

  /// 上拉加载更多
  Future<List<T>?> loadMore() async {
    try {
      var data = await loadData(pageNum: ++_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
        refreshController.loadNoData();
      } else {
        await onCompleted(data);
        list.addAll(data);
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        change(null, status: RxStatus.success());
      }
      return data;
    } catch (e, s) {
      _currentPageNum--;
      refreshController.loadFailed();
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
    }
  }

  // 加载数据
  Future<List<T>> loadData({int pageNum});

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  /// 获取返回数据回调
  Future onCompleted(List<T> data) async {}
}
