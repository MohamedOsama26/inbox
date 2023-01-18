import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/modules/new_post_screen/new_post_screen.dart';
import 'package:inbox/shared/widgets/build_post_item.dart';
import 'package:inbox/shared/widgets/resize_text_feild.dart';
import '../../main.dart';
import '../../models/social_cubit/social_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialState>(
      builder: (context, state) {
        if(state is ProfileInfoLoadingState){
          return const Center(child: CircularProgressIndicator(),);
        }
        if (state is ProfileInfoSuccessState) {
            return ListView.separated(
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewPostScreen()));
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 0.0),
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
                                shape: BoxShape.circle,
                                color: Color(0xFF0F66E3)),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.post_add),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return BuildPostItem(
                text: state.posts![index].text,
                name: state.posts![index].name,
                postImage: state.posts![index].postImage,
                uid: state.posts![index].uid,
                dateTime: state.posts![index].dateTime,
                profileImage: state.posts![index].profileImage,
                currentUserProfileImage: state.model!.profilePicture,
                postId: SocialCubit.get(context).postsId[index],
                likes: state.likes![index],
                index: index
              );
            },
            itemCount: state.posts!.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 8.0,
            ),
          );
          }
        else {
          SocialCubit.get(context).getUserData(uid);
          return const Center(
            child: Text('Loading'),
          );
        }
      },
    );
  }
}
