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
  final String status;
  final String active;
  final storage = const FlutterSecureStorage();

  const InfiniteScrollPaginatorDemo(
      {super.key,
      required this.id,
      required this.status,
      required this.active});

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
        Uri.parse(
            "${getUrl()}reportsntasks/paginated/${widget.status}/${widget.id}/$offset"),
      );

      List responseList = json.decode(response.body);
      // var databaseItemsNo = responseList.length;

      // print("Current items are now : $databaseItemsNo");

      List<Item> postList = responseList
          .map((data) => Item(data['Type'], data['Name'], data['Address'],
              data['Landmark'], data['City'], data['ID']))
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
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Item>(
          itemBuilder: (context, item, index) => Padding(
            padding: const EdgeInsets.all(0),
            child: IncidentBar(
                status: widget.status,
                type: item.type,
                name: item.name,
                address: item.address,
                landmark: item.landmark,
                city: item.city,
                customerID: item.customerID,
                id: widget.id),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
