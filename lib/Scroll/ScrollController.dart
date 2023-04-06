// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../Components/Utils.dart';
import '../Model/Item.dart';
import '../Components/IncidentBar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class InfiniteScrollPaginatorDemo extends StatefulWidget {
  final String id;
  final String active;
  final storage = const FlutterSecureStorage();

  const InfiniteScrollPaginatorDemo(
      {super.key, required this.id, required this.active});

  @override
  _InfiniteScrollPaginatorDemoState createState() =>
      _InfiniteScrollPaginatorDemoState();
}

class _InfiniteScrollPaginatorDemoState
    extends State<InfiniteScrollPaginatorDemo> {
  final _numberOfPostsPerRequest = 5;

  final PagingController<int, Item> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void didUpdateWidget(covariant InfiniteScrollPaginatorDemo oldWidget) {
    if (oldWidget.active != widget.active) {
      _pagingController.refresh();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _fetchPage(int pageKey) async {
    var offset = pageKey == 0 ? pageKey : pageKey + _numberOfPostsPerRequest;
    try {
      final response = await get(
        Uri.parse("${getUrl()}reports/paginated/${widget.id}/$offset"),
      );

      List responseList = json.decode(response.body);
      // var databaseItemsNo = responseList.length;

      // print("Current items are now : $databaseItemsNo");

      List<Item> postList = responseList
          .map((data) => Item(
              data['Title'],
              data['Description'],
              data['Keywords'],
              data['Image'],
              data['Lat'],
              data['Long'],
              data['ID']))
          .toList();

      print("the news item is now list is $postList");
      print("erid is ${widget.id} while customer id is $responseList");

      final isLastPage = postList.length < _numberOfPostsPerRequest;
      if (isLastPage) {
        _pagingController.appendLastPage(postList);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(postList, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedListView<int, Item>(
          shrinkWrap: true,
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Item>(
            itemBuilder: (context, item, index) => Padding(
              padding: const EdgeInsets.all(0),
              child: IncidentBar(
                  title: item.title,
                  description: item.description,
                  keywords: item.keywords,
                  image: item.image,
                  lat: item.lat,
                  long: item.long,
                  id: widget.id),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
