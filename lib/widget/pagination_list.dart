import 'dart:async';

import 'package:flutter/material.dart';

typedef PaginationBuilder<T> = Future<List<T>> Function(int currentListSize);

class PaginationList<T> extends StatefulWidget {
  const PaginationList({
    super.key,
    required this.itemBuilder,
    required this.onError,
    required this.onEmpty,
    required this.pageFetch,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.padding = EdgeInsets.zero,
    this.initialData = const [],
    this.physics,
    this.separatorWidget = const SizedBox(height: 0, width: 0),
    this.onPageLoading = const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            backgroundColor: Colors.amber,
          ),
        ),
      ),
    ),
    this.onLoading = const SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        backgroundColor: Colors.amber,
      ),
    ),
  });

  final Axis scrollDirection;
  final bool shrinkWrap;
  final EdgeInsets padding;
  final List<T> initialData;
  final PaginationBuilder<T> pageFetch;
  final ScrollPhysics? physics;
  final Widget Function(BuildContext, T) itemBuilder;
  final Widget onEmpty;
  final Widget Function(dynamic) onError;
  final Widget separatorWidget;
  final Widget onPageLoading;
  final Widget onLoading;

  @override
  _PaginationListState<T> createState() => _PaginationListState<T>();
}

class _PaginationListState<T> extends State<PaginationList<T>>
    with AutomaticKeepAliveClientMixin<PaginationList<T>> {
  late final List<T?> _itemList;
  dynamic _error;
  late final StreamController<PageState> _streamController;

  @override
  void initState() {
    super.initState();
    _itemList = List<T?>.from(widget.initialData)..add(null);
    _streamController = StreamController<PageState>();
    if (widget.initialData.isEmpty) {
      fetchPageData();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<PageState>(
      stream: _streamController.stream,
      initialData: PageState.firstLoad,
      builder: (BuildContext context, AsyncSnapshot<PageState> snapshot) {
        if (!snapshot.hasData) {
          return widget.onLoading;
        }
        if (snapshot.data == PageState.firstLoad) {
          return widget.onLoading;
        }
        if (snapshot.data == PageState.firstEmpty) {
          return widget.onEmpty;
        }
        if (snapshot.data == PageState.firstError) {
          return widget.onError(_error);
        }
        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            if (_itemList[index] == null) {
              fetchPageData(offset: index);
              return widget.onPageLoading;
            }
            return widget.itemBuilder(context, _itemList[index]!);
          },
          shrinkWrap: widget.shrinkWrap,
          scrollDirection: widget.scrollDirection,
          physics: widget.physics,
          padding: widget.padding,
          itemCount: _itemList.length,
          separatorBuilder: (BuildContext context, int index) =>
              widget.separatorWidget,
        );
      },
    );
  }

  void fetchPageData({int offset = 0}) {
    widget.pageFetch(_itemList.length - 1).then(
      (List<T> list) {
        _itemList.remove(null);
        if (list.isEmpty) {
          if (offset == 0) {
            _streamController.add(PageState.firstEmpty);
          } else {
            _streamController.add(PageState.pageEmpty);
          }
          return;
        }

        _itemList.addAll(list);
        _itemList.add(null);
        _streamController.add(PageState.pageLoad);
      },
      onError: (dynamic _error) {
        this._error = _error;
        if (offset == 0) {
          _streamController.add(PageState.firstError);
        } else {
          _itemList.add(null);
          _streamController.add(PageState.pageError);
        }
      },
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

enum PageState {
  pageLoad,
  pageError,
  pageEmpty,
  firstEmpty,
  firstLoad,
  firstError,
}
