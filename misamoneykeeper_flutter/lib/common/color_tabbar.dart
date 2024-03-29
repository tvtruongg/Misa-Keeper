import 'package:misamoneykeeper_flutter/utility/export.dart';

class ColoredTabBar extends Container implements PreferredSizeWidget {
  ColoredTabBar(this.color, this.tabBar, {super.key});

  @override
  final Color color;
  final TabBar tabBar;
  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(color: color, child: tabBar);
}
