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
      tilePadding: const EdgeInsets.symmetric(horizontal: 20),
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

class SettingAnnouncement extends StatelessWidget {
  const SettingAnnouncement({super.key});

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context)!;
    final List<Entry> data = <Entry>[
      Entry(
        localization.trans('ANNOUNCEMENT_1'),
        <Entry>[Entry(localization.trans('ANNOUNCEMENT_TXT_1'))],
      ),
      Entry(
        localization.trans('ANNOUNCEMENT_2'),
        <Entry>[Entry(localization.trans('ANNOUNCEMENT_TXT_2'))],
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
          localization.trans('ANNOUNCEMENT')!,
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
