import 'package:flutter/material.dart';

import 'package:wecount/widgets/header.dart' show renderHeaderBack;
import 'package:wecount/utils/localization.dart';

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

class SettingFAQ extends StatelessWidget {
  const SettingFAQ({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Entry> data = <Entry>[
      Entry(
        localization(context).faq1,
        <Entry>[Entry(localization(context).faqTxt1)],
      ),
      Entry(
        localization(context).faq2,
        <Entry>[Entry(localization(context).faqTxt2)],
      ),
      Entry(
        localization(context).faq3,
        <Entry>[Entry(localization(context).faqTxt3)],
      ),
      Entry(
        localization(context).faq4,
        <Entry>[Entry(localization(context).faqTxt4)],
      ),
      Entry(
        localization(context).faq5,
        <Entry>[Entry(localization(context).faqTxt5)],
      ),
      Entry(
        localization(context).faq6,
        <Entry>[Entry(localization(context).faqTxt6)],
      ),
      Entry(
        localization(context).faq7,
        <Entry>[Entry(localization(context).faqTxt7)],
      ),
      Entry(
        localization(context).faq8,
        <Entry>[Entry(localization(context).faqTxt8)],
      ),
      Entry(
        localization(context).faq9,
        <Entry>[Entry(localization(context).faqTxt9)],
      ),
      Entry(
        localization(context).faq10,
        <Entry>[Entry(localization(context).faqTxt10)],
      ),
      Entry(
        localization(context).faq11,
        <Entry>[Entry(localization(context).faqTxt11)],
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
          localization(context).faq,
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
