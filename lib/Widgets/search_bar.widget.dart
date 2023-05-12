import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SearchBar extends StatefulWidget {
  final bool isYt;
  final Widget body;
  final bool autofocus;
  final bool liveSearch;
  final bool showClose;
  final Widget? leading;
  final String? hintText;
  final TextEditingController controller;
  final Function(String)? onQueryChanged;
  final Function()? onQueryCleared;
  final Function(String) onSubmitted;
  const SearchBar({
    super.key,
    this.leading,
    this.hintText,
    this.showClose = true,
    this.autofocus = false,
    this.onQueryChanged,
    this.onQueryCleared,
    required this.body,
    required this.isYt,
    required this.controller,
    required this.liveSearch,
    required this.onSubmitted,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String tempQuery = '';
  String query = '';
  final ValueNotifier<bool> hide = ValueNotifier<bool>(true);
  final ValueNotifier<List> suggestionsList = ValueNotifier<List>([]);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.body,
        ValueListenableBuilder(
          valueListenable: hide,
          builder: (
            BuildContext context,
            bool hidden,
            Widget? child,
          ) {
            return Visibility(
              visible: !hidden,
              child: GestureDetector(
                onTap: () {
                  hide.value = true;
                },
              ),
            );
          },
        ),
        Container(
      margin: const EdgeInsets.fromLTRB(
        20.0,
        10.0,
        20.0,
        10.0,
      ),
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 7,
      ),
      height: 52.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[900],
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            offset: Offset(0.0, 3.0),
          )
        ],
      ),
      child: TextField(
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.transparent,
            ),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 1.5),
            child: widget.leading,
          ),
          prefixIconColor: Colors.white,
          suffixIcon: Visibility(
            visible: true,
            child: Padding(
              padding: EdgeInsets.only(top: 1.5),
              child: IconButton(
                splashColor: Colors.transparent,
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  widget.controller.text = '';
                  suggestionsList.value = [];
                  if (widget.onQueryCleared != null) {
                    widget.onQueryCleared!.call();
                  }
                },
              ),
            ),
          ),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.white70,
          ),
        ),
        autofocus: widget.autofocus,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        onChanged: (val) {
          Future.delayed(
            const Duration(
              milliseconds: 600,
            ),
            () async {
              if (tempQuery == val &&
                  tempQuery.trim() != '' &&
                  tempQuery != query) {
                query = tempQuery;
                if (widget.onQueryChanged == null) {
                  widget.onSubmitted(tempQuery);
                } else {
                  widget.onQueryChanged!(tempQuery);
                }
              }
            },
          );
        },
        onSubmitted: (submittedQuery) {
          if (submittedQuery.trim() != '') {
            query = submittedQuery;
            widget.onSubmitted(submittedQuery);
            if (!hide.value) hide.value = true;
            List searchQueries = Hive.box('settings')
                .get('search', defaultValue: []) as List;
            searchQueries.insert(0, query);
            if (searchQueries.length > 10) {
              searchQueries = searchQueries.sublist(0, 10);
            }
            Hive.box('settings').put('search', searchQueries);
          }
        },
      ),
    )
        ],
    );
    }
}
