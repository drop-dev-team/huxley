import 'package:flutter/material.dart';
import '../../../dynamic/layout/responsive_sizer.dart';

class ListItems extends StatefulWidget {
  final int numberOfItems;
  final BuildContext context;
  final List<VoidCallback> callbacks; // List of callbacks for each item
  final List<String> titles; // List of titles for each item
  final List<IconData> icons; // List of icons for each item

  const ListItems({
    super.key,
    required this.numberOfItems,
    required this.context,
    required this.callbacks,
    required this.titles,
    required this.icons,
  })  : assert(numberOfItems > 0, 'There must be at least one item.'),
        assert(titles.length == numberOfItems && icons.length == numberOfItems && callbacks.length == numberOfItems, 'Titles, icons, and callbacks lists must all match the number of items.');

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  late double itemHeight;
  static const double dividerHeight = 1.0;
  bool isLayoutCompleted = false;

  @override
  void initState() {
    super.initState();
    itemHeight = ResponsiveSizer().popoverListHeight(widget.context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          isLayoutCompleted = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLayoutCompleted ? ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: widget.numberOfItems,
      separatorBuilder: (_, __) => const Divider(height: dividerHeight),
      itemBuilder: (BuildContext context, int index) {
        if (index < widget.titles.length && index < widget.icons.length && index < widget.callbacks.length) {
          return _buildListItem(widget.titles[index], widget.icons[index], widget.callbacks[index]);
        } else {
          // Optionally log an error or handle this case as needed
          return const SizedBox.shrink();
        }
      },
    ) : const SizedBox(); // Optionally return a loading spinner or similar widget here
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
