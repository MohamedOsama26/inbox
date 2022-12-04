import 'package:flutter/material.dart';
import 'package:inbox/shared/Icons/inbox_navigation_icons_icons.dart';

class InboxNavBar extends StatefulWidget {
  const InboxNavBar({Key? key, required this.controller, required this.pageIndex})
      : super(key: key);

  final int pageIndex;
  final PageController controller;

  @override
  State<InboxNavBar> createState() => _InboxNavBarState();
}

class _InboxNavBarState extends State<InboxNavBar> {
  final int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.00),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.00),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 2)
          ],
          color: Colors.white),
      child: NavigationBar(
        selectedIndex: _index,
        backgroundColor: Colors.transparent,
        destinations: [
          IconButton(
            color: widget.pageIndex == 0 ? const Color(0xFFFF4747):const Color(0xFF000000),
            icon: const Icon(InboxNavigationIcons.HomeIcon,),
            onPressed: () {
              if (widget.controller.hasClients) {
                widget.controller.animateToPage(0,
                    duration: const Duration(milliseconds: 10), curve: Curves.linear);
                print(_index);
              }
            },
          ),
          IconButton(
            color: widget.pageIndex == 1 ? const Color(0xFFFF4747):const Color(0xFF000000),
            icon: const Icon(InboxNavigationIcons.ChatIcon),
            onPressed: () {
              if (widget.controller.hasClients) {
                widget.controller.animateToPage(1,
                    duration: const Duration(milliseconds: 10), curve: Curves.linear);
                print(_index);
              }
            },
          ),
          IconButton(
            color: widget.pageIndex == 2 ? const Color(0xFFFF4747):const Color(0xFF000000),
            icon: const Icon(InboxNavigationIcons.StoryIcon),
            onPressed: () {
              if (widget.controller.hasClients) {
                widget.controller.animateToPage(2,
                    duration: const Duration(milliseconds: 10), curve: Curves.linear);
                print(_index);
              }
            },
          ),
          IconButton(
            color: widget.pageIndex == 3 ? const Color(0xFFFF4747):const Color(0xFF000000),
            icon: const Icon(InboxNavigationIcons.ProfileIcon),
            onPressed: () {
              if (widget.controller.hasClients) {
                widget.controller.animateToPage(3,
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.linear);
              }
            },
          ),
        ],
      ),
    );
  }
}
