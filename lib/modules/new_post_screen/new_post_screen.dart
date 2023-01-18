import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/models/social_cubit/social_cubit.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'New post',
              style: TextStyle(color: Color(0x6F000000), fontSize: 24),
            ),
            iconTheme: const IconThemeData(color: Colors.black45),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TextButton(
                    onPressed: () {
                      if (SocialCubit.get(context).postImage != null ||
                          textController.text.isNotEmpty) {
                        if (SocialCubit.get(context).postImage == null) {
                          SocialCubit.get(context).createPost(
                              dateTime: DateTime.now().toString(),
                              text: textController.text);
                        } else {
                          SocialCubit.get(context).uploadPostImage(
                              dateTime: DateTime.now().toString(),
                              text: textController.text);
                        }
                      }
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Post',
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
          body: SizedBox(
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 34.0,
                        backgroundImage: NetworkImage(
                            SocialCubit.get(context).model!.profilePicture),
                      ),
                      // ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${SocialCubit.get(context).model!.firstName} ${SocialCubit.get(context).model!.lastName}',
                            style: const TextStyle(
                                color: Color(0xA6000000),
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const Text(
                            '\u{1F30D}  public ',
                            style: TextStyle(
                              color: Color(0x66000000),
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What\'s in your mind ...',
                      ),
                      maxLines: null,
                      // ),
                    ),
                  ),
                  if (SocialCubit.get(context).postImage != null)
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(
                                      SocialCubit.get(context).postImage!))),
                        ),
                        IconButton(
                          icon: const CircleAvatar(
                              radius: 20.0,
                              child: Icon(
                                Icons.close,
                                size: 16.0,
                              )),
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          color: Colors.white,
                        )
                      ],
                    ),
                  Row(
                    children: [
                      Expanded(
                          child: MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).pickPostImage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.camera_alt_outlined),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text('Photo/video'),
                                ],
                              ))),
                      Expanded(
                          child: MaterialButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.tag),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text('Tag friends'),
                                ],
                              ))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
