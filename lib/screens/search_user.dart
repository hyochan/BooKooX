import 'package:flutter/material.dart';
import 'package:wecount/shared/header.dart';
import 'package:wecount/shared/loading_indicator.dart';
import 'package:wecount/shared/search_text_filed.dart';
import 'package:wecount/utils/logger.dart';

import '../utils/localization.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  bool _isLoading = false;
  void _onSearchTextChanged(String searchText) {
    setState(() => _isLoading = true);
    _search();
  }

  Future<void> _search() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderHeaderClose(context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: SearchTextField(
                  autofocus: true,
                  onSearched: _onSearchTextChanged,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: t('SEARCH_USER_HINT'),
                  ),
                ),
              ),
              _isLoading
                  ? const SizedBox(
                      height: 50,
                      child: LoadingIndicator(
                        size: 40,
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t("NO_WECOUNT_USER"),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  t("INVITE"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
