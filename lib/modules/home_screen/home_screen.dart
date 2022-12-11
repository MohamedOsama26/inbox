import 'package:flutter/material.dart';
import 'package:inbox/shared/widgets/post.dart';
import 'package:inbox/shared/widgets/resize_text_feild.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (index == 0) {
          return Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 34.0,
                      backgroundImage: NetworkImage(
                        'https://lh3.googleusercontent.com/u/1/drive-viewer/AFDK6gPA2aa7pJPjxae4DMKZFtgNOl7RhZzzoUMB1-Sd-uUsKIEraseFPCGNVMF-WBYtty7YmTTV0azYWhxjGw3uNykwWx8sXA=w1848-h995',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ResizeTextField(
                      padding: const EdgeInsets.all(0),
                      multiLine: false,
                      commentController: postController,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF0F66E3)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.post_add),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Post();
      },
      itemCount: 3,
      separatorBuilder: (context, index) => const SizedBox(
        height: 8.0,
      ),
    );
  }
}
