import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/models/social_cubit/social_cubit.dart';
import 'package:inbox/shared/widgets/post_attachents.dart';
import 'package:inbox/shared/widgets/resize_text_feild.dart';

class BuildPostItem extends StatefulWidget {
  final String name;
  final String postImage;
  final String text;
  final String uid;
  final String dateTime;
  final String profileImage;
  final String currentUserProfileImage;
  final int likes;
  final String postId;


  const BuildPostItem({
    super.key,
    required this.name,
    required this.postImage,
    required this.text,
    required this.uid,
    required this.dateTime,
    required this.profileImage,
    required this.currentUserProfileImage,
    required this.postId,
    required this.likes,
  });

  @override
  State<BuildPostItem> createState() => _BuildPostItem();
}

void submittedEffect(BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        decoration: BoxDecoration(
            color: const Color(0x8C000000),
            borderRadius: BorderRadius.circular(50)),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 50,
        child: const Center(
          child: Text(
            'D o n e  \u{1F609}',
            style: TextStyle(fontSize: 20, color: Color(0xDAFFFFFF)),
          ),
        ),
      ),
      duration: const Duration(seconds: 1),
    ),
  );
}

class _BuildPostItem extends State<BuildPostItem> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  RegExp reg = RegExp(r"^[\u0621-\u064A0-9 ]");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 10,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: Column(
          children: [
            //Information about post and menu
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 34.0,
                    backgroundImage: NetworkImage(widget.profileImage),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                          color: Color(0xA6000000),
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      widget.dateTime,
                      style: const TextStyle(
                        color: Color(0x66000000),
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                  ),
                  child: const Icon(Icons.more_vert_outlined,
                      size: 32, color: Color(0xFF606060)),
                ),
              ],
            ),
            const SizedBox(
              height: 6.0,
            ),
            if (widget.postImage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0, top: 4),
                child: PostAttachments(postImage: widget.postImage),
              ),
            //Text content in the post
            Padding(
              padding:
              const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16),
              child: Wrap(
                children: [Text(widget.text)],
              ),
            ),
            //Buttons and numbers of likes and comments
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
              height: 28,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<SocialCubit, SocialState>(
                    builder: (context, state) {
                      return TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            minimumSize: const Size(3, 2)),
                        onPressed: () {
                          print('---------------------');
                          print(widget.postId);
                          print('---------------------');
                          SocialCubit.get(context).likePost(widget.postId);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.favorite_border,
                              // color: Colors.blue,
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              '${widget.likes}',
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        minimumSize: const Size(3, 2)),
                    onPressed: () => print('comments'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.comment_outlined,
                          // color: Colors.blue,
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          '532',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //Comment Row in the post
            Form(
              key: formKey,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                          widget.currentUserProfileImage
                        // SocialCubit.get(context).model!.profilePicture
                      ),
                    ),
                    const SizedBox(
                      width: 2.0,
                    ),
                    Expanded(
                      child: ResizeTextField(
                          commentController: commentController,
                          multiLine: true,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2)),
                    ),
                    const SizedBox(
                      width: 2.0,
                    ),
                    CircleAvatar(
                        child: IconButton(
                          onPressed: () {
                            if (commentController.text.isNotEmpty) {
                              FocusScope.of(context).unfocus();
                              submittedEffect(context);
                              commentController.clear();
                            } else {
                              FocusScope.of(context).unfocus();
                            }
                          },
                          icon: const Icon(Icons.send),
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
