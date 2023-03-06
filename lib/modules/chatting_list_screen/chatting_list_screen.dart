import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inbox/models/social_cubit/social_cubit.dart';
import 'package:inbox/shared/widgets/person_card.dart';

class ChattingListScreen extends StatelessWidget {
   const ChattingListScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //The application bar for chatting page
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              Text(
                'I n b o x',
                style: GoogleFonts.nerkoOne(
                  fontWeight: FontWeight.w200,
                  fontSize: 28,
                  color: const Color(0xBD000000),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                iconSize: 30,
              ),
              IconButton(
                color: const Color(0xE5000000),
                iconSize: 30,
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
        ),

        //The list of chats

        Expanded(
          child:
              BlocBuilder<SocialCubit, SocialState>(builder: (context, state) {
            print('this is the state $state');
            if (state is GetAllUsersSuccessState) {
              print(state.allUsers);
              return ListView.separated(
                physics: const PageScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return PersonCard(
                    fullName:
                        '${state.allUsers[index].firstName} ${state.allUsers[index].lastName}',
                    birthday: DateTime(1999, 12, 2),
                    userPhoto: state.allUsers[index].profilePicture,
                    chatPerson: state.allUsers[index],
                  );
                },
                itemCount: state.allUsers.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
              );
            } else if (state is GetAllUsersErrorState) {
              return Center(
                child: Text(state.error),
              );
            } else {
              print(state);
              SocialCubit.get(context).getAllUsers();
              return const Center(child: CircularProgressIndicator());
            }
          }),
        )
      ],
    );
  }
}
