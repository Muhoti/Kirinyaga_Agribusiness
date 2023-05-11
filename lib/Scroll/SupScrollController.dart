// ignore_for_file: file_names, library_private_types_in_public_api, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../Components/SuIncidentBar.dart';
import '../Components/Utils.dart';
import '../Model/FOItem.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SupScrollController extends StatefulWidget {
  final String id;
  final String active;
  final String status;
  final storage = const FlutterSecureStorage();

  const SupScrollController(
      {super.key,
      required this.id,
      required this.active,
      required this.status});

  @override
  _SupScrollControllerState createState() => _SupScrollControllerState();
}

class _SupScrollControllerState extends State<SupScrollController> {
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
  void didUpdateWidget(covariant SupScrollController oldWidget) {
    if (oldWidget.active != widget.active) {
      _pagingController.refresh();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _fetchPage(int pageKey) async {
    var offset = pageKey == 0 ? pageKey : pageKey + _numberOfPostsPerRequest;
    try {
      final dynamic response;
   
      widget.status == "Pending"
          ? response = await get(
              Uri.parse("${getUrl()}workplan/supervisor/null/${widget.id}/$offset"),
            )
          : response = await get(
              Uri.parse("${getUrl()}workplan/supervisor/true/${widget.id}/$offset"),
            );

      List responseList = json.decode(response.body);

      var databaseItemsNo = responseList.length;
    
      List<FOItem> postList = responseList.map((data) => FOItem(data)).toList();

      final isLastPage = postList.length < _numberOfPostsPerRequest;
      if (isLastPage) {
        _pagingController.appendLastPage(postList);
      } else {
        final nextPageKey = pageKey + _numberOfPostsPerRequest;
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
              child: SuIncidentBar(item: item),
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
