import 'package:flutter/material.dart';

import '../../../dynamic/layout/responsive_sizer.dart';

class ListItems extends StatefulWidget {
  final int numberOfItems;
  final BuildContext context;
  final List<VoidCallback> callbacks; // List of callbacks for each item
  final List<String> titles; // List of titles for each item
  final List<IconData> icons; // List of icons for each item
  static double totalHeight = 0;

  const ListItems({
    super.key,
    required this.numberOfItems,
    required this.context,
    required this.callbacks,
    required this.titles,
    required this.icons,
  })  : assert(numberOfItems > 1, 'There must be more than one item.'),
        assert(titles.length == numberOfItems && icons.length == numberOfItems, 'Titles and icons lists must match the number of items.');

  @override
  State<ListItems> createState() => _ListItemsState();

  static double getTotalHeight() {
    return totalHeight;
  }
}

class _ListItemsState extends State<ListItems> {
  late double itemHeight;
  static const double dividerHeight = 1.0;

  @override
  void initState() {
    super.initState();
    itemHeight = ResponsiveSizer().popoverListHeight(widget.context);
    ListItems.totalHeight = (itemHeight * widget.numberOfItems) + (dividerHeight + 10);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ListItems.totalHeight,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: widget.numberOfItems,
        separatorBuilder: (_, __) => const Divider(height: dividerHeight),
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(widget.titles[index], widget.icons[index], widget.callbacks[index]);
        },
      ),
    );
  }

  Widget _buildListItem(String title, IconData icon, VoidCallback callback) {
    return InkWell(
      onTap: callback,
      child: ListTile(
        title: Text(title),
        trailing: Icon(icon),
      ),
    );
  }
}
