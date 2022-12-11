import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          child: ListView.separated(
            physics: const PageScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return PersonCard(
                birthday: DateTime(1999, 12, 2),
              );
            },
            itemCount: 10,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 8,
              );
            },
          ),
        ),
      ],
    );
  }
}
