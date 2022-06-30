import 'dart:async';

import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    Key? key,
    required this.onSearched,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.style,
    this.decoration,
    this.autofocus = false,
  }) : super(key: key);

  final void Function(String) onSearched;
  final Duration debounceDuration;
  final TextStyle? style;
  final InputDecoration? decoration;
  final bool autofocus;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Timer? _debounce;

  void _onSearchTextChanged(String text) {
    _cancelDebounceSearching();

    _debounce = Timer(widget.debounceDuration, () {
      String searchText = text.trim();

      if (searchText.isNotEmpty) {
        widget.onSearched(searchText);
      }
    });
  }

  void _cancelDebounceSearching() {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
  }

  @override
  void dispose() {
    _cancelDebounceSearching();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.autofocus,
      onChanged: _onSearchTextChanged,
      style: widget.style,
      decoration: widget.decoration,
    );
  }
}
