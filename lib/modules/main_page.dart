import 'package:flutter/material.dart';
import 'package:inbox/modules/chatting_list_screen/chatting_list_screen.dart';
import 'package:inbox/modules/home_screen/home_screen.dart';
import 'package:inbox/modules/profile_screen/profile_screen.dart';
import 'package:inbox/modules/reels_screen/reels_screen.dart';
import 'package:inbox/shared/widgets/inbox_app_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final PageController controller = PageController();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  InboxNavBar(controller: controller,pageIndex: currentPageIndex),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 16.0,left: 16.0,right: 16.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.00),
              boxShadow: const [BoxShadow(color: Colors.black26,blurRadius: 8,spreadRadius: 2)],
              color: Colors.white
          ),
          child: PageView(


            controller: controller,
              children:   [
            HomeScreen(),
            ChattingListScreen(),
            ReelsScreen(),
            ProfileScreen(),
          ],
            onPageChanged: (pageIndex){
              setState(() {
                currentPageIndex = pageIndex;
              });
            },
          ),

        ),
      ),
    );
  }
}
