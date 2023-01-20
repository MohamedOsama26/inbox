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
                           Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              backgroundImage: NetworkImage(state.model!.profilePicture),
                              radius: 34.0,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                              decoration:  BoxDecoration(
                                  border: Border.all(color: const Color(0x8BB4B4B4),width: 2,),
                                borderRadius: BorderRadius.circular(14)
                              ),
                              child: const Text(
                                'Create new post ...',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFB4B4B4),
                                ),
                              ),
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
                comments: state.comments![index],
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
