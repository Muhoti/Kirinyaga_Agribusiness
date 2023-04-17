// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../Components/Utils.dart';
import '../Model/FOItem.dart';
import '../Components/FOIncidentBar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FOScrollController extends StatefulWidget {
  final String id;
  final String active;
  final String status;
  final storage = const FlutterSecureStorage();

  const FOScrollController(
      {super.key,
      required this.id,
      required this.active,
      required this.status});

  @override
  _FOScrollControllerState createState() => _FOScrollControllerState();
}

class _FOScrollControllerState extends State<FOScrollController> {
  final _numberOfPostsPerRequest = 5;

  final PagingController<int, FOItem> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void didUpdateWidget(covariant FOScrollController oldWidget) {
    if (oldWidget.active != widget.active) {
      _pagingController.refresh();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _fetchPage(int pageKey) async {
    print("widget id ${widget.id}");
    print("the status is ${widget.status}");
    var offset = pageKey == 0 ? pageKey : pageKey + _numberOfPostsPerRequest;
    try {
      final dynamic response;

      widget.status == "Pending"
          ? response = await get(
              Uri.parse("${getUrl()}workplan/fieldofficer/${widget.id}"),
            )
          : response = await get(
              Uri.parse("${getUrl()}reports/fieldofficer/${widget.id}"),
            );

      List responseList = json.decode(response.body);

      var databaseItemsNo = responseList.length;

      print("Current items are now : $responseList");

      List<FOItem> postList = responseList
          .map((data) => FOItem(
              data['Title'],
              data['Description'],
              data['Keywords'],
              data['Image'],
              data['Latitude'],
              data['Longitude'],
              data['ID'],
              widget.status == "Pending"
                  ? data['createdAt']
                  : data['updatedAt']))
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
        child: PagedListView<int, FOItem>(
          shrinkWrap: true,
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<FOItem>(
            itemBuilder: (context, item, index) => Padding(
              padding: const EdgeInsets.all(0),
              child: FOIncidentBar(
                  title: item.title,
                  description: item.description,
                  status: widget.status,
                  keywords: item.keywords,
                  image: item.image,
                  lat: item.lat,
                  long: item.long,
                  id: item.id,
                  createdat: item.createdat),
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
