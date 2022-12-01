import 'package:flutter/material.dart';

import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/utils/localization.dart' show Localization;

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String? title;
  final List<Entry> children;
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry, {super.key});

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
  const SettingFAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context)!;
    final List<Entry> data = <Entry>[
      Entry(
        localization.trans('FAQ_1'),
        <Entry>[Entry(localization.trans('FAQ_TXT_1'))],
      ),
      Entry(
        localization.trans('FAQ_2'),
        <Entry>[Entry(localization.trans('FAQ_TXT_2'))],
      ),
      Entry(
        localization.trans('FAQ_3'),
        <Entry>[Entry(localization.trans('FAQ_TXT_3'))],
      ),
      Entry(
        localization.trans('FAQ_4'),
        <Entry>[Entry(localization.trans('FAQ_TXT_4'))],
      ),
      Entry(
        localization.trans('FAQ_5'),
        <Entry>[Entry(localization.trans('FAQ_TXT_5'))],
      ),
      Entry(
        localization.trans('FAQ_6'),
        <Entry>[Entry(localization.trans('FAQ_TXT_6'))],
      ),
      Entry(
        localization.trans('FAQ_7'),
        <Entry>[Entry(localization.trans('FAQ_TXT_7'))],
      ),
      Entry(
        localization.trans('FAQ_8'),
        <Entry>[Entry(localization.trans('FAQ_TXT_8'))],
      ),
      Entry(
        localization.trans('FAQ_9'),
        <Entry>[Entry(localization.trans('FAQ_TXT_9'))],
      ),
      Entry(
        localization.trans('FAQ_10'),
        <Entry>[Entry(localization.trans('FAQ_TXT_10'))],
      ),
      Entry(
        localization.trans('FAQ_11'),
        <Entry>[Entry(localization.trans('FAQ_TXT_11'))],
      ),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).iconTheme.color,
        brightness: Theme.of(context).brightness,
        title: Text(
          localization.trans('FAQ')!,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).textTheme.displayLarge!.color,
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
