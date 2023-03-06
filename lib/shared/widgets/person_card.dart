import 'package:flutter/material.dart';
import 'package:inbox/layout/user_model.dart';
import 'package:inbox/models/social_cubit/social_cubit.dart';
import 'package:inbox/modules/chatting_screen/chatting_screen.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({Key? key, required this.birthday,required this.fullName, required this.userPhoto, required this.chatPerson }) : super(key: key);

  final DateTime birthday;
  final String fullName;
  final String userPhoto;
  final UserModel chatPerson;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('pushed');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>  ChattingScreen(
          chatPerson: chatPerson,
        )));
      },
      child: SizedBox(
        height: 100,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [

            // The big container for the chat box
            Container(
              margin: const EdgeInsets.only(left: 38, right: 16),
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black45, spreadRadius: 1, blurRadius: 2),
                  ],),
              padding: const EdgeInsets.only(left: 60, top: 12, bottom: 12,right: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  [
                  Text(
                    fullName,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const Expanded(
                    child: Text(
                      '\u{231B} This is the message content you sent but didn\'t arrive',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        height: 2,
                      ),
                    ),
                  ),
                  const Text(
                    'today 03:09 PM',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),

            // The circle for profile picture
             Positioned(
              left: 16,
              child: CircleAvatar(
                radius: 36,
                backgroundImage: NetworkImage(
                  userPhoto ?? ''
                ),
              ),
            ),

            //The circle for number of new messages
            const Positioned(
              bottom: 14,
              left: 14,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.green,
                  child: Text(
                    '+99',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),

            //The item of birthday mark
            Positioned(
              top: 0,
              right: 8,
              child: birthdayCalculator(birthday),
            ),
          ],
        ),
      ),
    );
  }

  //Function which build birthday mark
  Widget birthdayCalculator(DateTime birthday) {
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(const Duration(days: 1));

    if (birthday.month == tomorrow.month && birthday.day == tomorrow.day) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFFF4747),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Text(
          '\u{1F382} Tomorrow ',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else if (birthday.month == today.month && birthday.day == today.day) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFFF4747),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Text(
          '\u{1F382}',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
