import 'package:flutter/material.dart';

import 'package:wecount/shared/header.dart' show renderHeaderBack;
import 'package:wecount/utils/localization.dart';

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String? title;
  final List<Entry> children;
}

class EntryItem extends StatelessWidget {
  const EntryItem(
    this.entry, {
    Key? key,
  }) : super(key: key);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title!));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title ?? ''),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

class SettingFAQ extends StatelessWidget {
  static const String name = '/setting_faq';

  const SettingFAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Entry> data = <Entry>[
      Entry(
        t('FAQ_1'),
        <Entry>[Entry(t('FAQ_TXT_1'))],
      ),
      Entry(
        t('FAQ_2'),
        <Entry>[Entry(t('FAQ_TXT_2'))],
      ),
      Entry(
        t('FAQ_3'),
        <Entry>[Entry(t('FAQ_TXT_3'))],
      ),
      Entry(
        t('FAQ_4'),
        <Entry>[Entry(t('FAQ_TXT_4'))],
      ),
      Entry(
        t('FAQ_5'),
        <Entry>[Entry(t('FAQ_TXT_5'))],
      ),
      Entry(
        t('FAQ_6'),
        <Entry>[Entry(t('FAQ_TXT_6'))],
      ),
      Entry(
        t('FAQ_7'),
        <Entry>[Entry(t('FAQ_TXT_7'))],
      ),
      Entry(
        t('FAQ_8'),
        <Entry>[Entry(t('FAQ_TXT_8'))],
      ),
      Entry(
        t('FAQ_9'),
        <Entry>[Entry(t('FAQ_TXT_9'))],
      ),
      Entry(
        t('FAQ_10'),
        <Entry>[Entry(t('FAQ_TXT_10'))],
      ),
      Entry(
        t('FAQ_11'),
        <Entry>[Entry(t('FAQ_TXT_11'))],
      ),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).iconTheme.color,
        brightness: Theme.of(context).brightness,
        title: Text(
          t('FAQ'),
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).textTheme.headline1!.color,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            EntryItem(data[index]),
        itemCount: data.length,
      ),
    );
  }
}
