// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/layout/user_model.dart';
import 'package:inbox/models/social_cubit/social_cubit.dart';
import 'package:inbox/models/userCubit/user_cubit.dart';
import 'package:inbox/shared/widgets/chat_message.dart';

class ChattingScreen extends StatelessWidget {
  ChattingScreen({super.key, required this.chatPerson});

  final UserModel chatPerson;
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.black45),
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(chatPerson.profilePicture),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  '${chatPerson.firstName} ${chatPerson.lastName}',
                  style: const TextStyle(color: Colors.black45),
                )
              ],
            ),
          ),
          body: Column(
            // crossAxisAlignment: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 12.0,
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (index % 2 == 0) {
                        print(index);
                        return sentMessage(
                            context,
                            true,
                            'Helhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhlo',
                            chatPerson);
                      } else {
                        return receivedMessage(context, true, 'content');
                      }
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 4.0,
                        ),
                    itemCount: 9),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Enter your message',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                          controller: messageController,
                        ),
                      ),
                      Container(
                        child: IconButton(
                            onPressed: () {
                              SocialCubit.get(context).sendChatMessage(
                                  receiverId: chatPerson.uid,
                                  messageContent: messageController.text,
                                  senderId:
                                      SocialCubit.get(context).userModel!.uid);
                              messageController.clear();
                            },
                            icon: const Icon(Icons.send)),
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget sentMessage(
      BuildContext context, bool sent, String content, UserModel chatPerson) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 12.0),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Text(
            content,
            textDirection: TextDirection.ltr,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget receivedMessage(BuildContext context, bool sent, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 12.0),
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Text(
            content,
            textDirection: TextDirection.ltr,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
