import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/models/social_cubit/social_cubit.dart';
import 'package:inbox/modules/login_screen/login_screen.dart';
import 'package:inbox/modules/settings_screen/settings_screen.dart';
import 'package:inbox/shared/links.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProfileInfoSuccessState) {
          return ListView(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: NetworkImage(backgroundProfilePicture),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                          SocialCubit.get(context).model!.profilePicture),
                    ),
                  ),
                ],
              ),
              Text(
                '${SocialCubit.get(context).model!.firstName} ${SocialCubit.get(context).model!.lastName}',
                style: const TextStyle(
                    height: 2,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xE2383838)),
                textAlign: TextAlign.center,
              ),
              Text(
                SocialCubit.get(context).model!.bio,
                style: const TextStyle(
                  height: 2,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xE2383838),
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: const [
                            Text(
                              '100',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Posts',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Color(
                                  0x93000000,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: const [
                              Text(
                                '1439',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Followers',
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Color(
                                    0x93000000,
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: const [
                            Text(
                              '23k',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Media',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Color(
                                  0x93000000,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: const [
                              Text(
                                '42k',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Following',
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Color(
                                    0x93000000,
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.alternate_email,
                          size: 16,
                          color: Colors.grey,
                        ),
                        Text(
                          ' Email',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 8,
                    ),
                    Text(
                      SocialCubit.get(context).model!.email,
                      style: const TextStyle(
                          height: 1.6,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.portrait_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            Text(
                              ' Title',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 8,
                        ),
                        Text(
                          SocialCubit.get(context).model!.title,
                          style: const TextStyle(
                              height: 1.6,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        )
                      ],
                    )),
                    const SizedBox(
                      width: 28,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.phone,
                              size: 16,
                              color: Colors.grey,
                            ),
                            Text(
                              ' Phone',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 8,
                        ),
                        Text(
                          SocialCubit.get(context).model!.phone,
                          style: const TextStyle(
                              height: 1.6,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        )
                      ],
                    )),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.cake_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            Text(
                              ' Birthday',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 8,
                        ),
                        Text(
                          SocialCubit.get(context).model!.birthday,
                          style: const TextStyle(
                              height: 1.6,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        )
                      ],
                    )),
                    const SizedBox(
                      width: 28,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            Text(
                              ' city',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 8,
                        ),
                        Text(
                          SocialCubit.get(context).model!.city,
                          style: const TextStyle(
                              height: 1.6,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        )
                      ],
                    )),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Divider(
                  height: 20,
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0x6040000),
                  child: TextButton(
                    style: const ButtonStyle(alignment: Alignment.centerLeft),
                    onPressed: () {
                      print('Friends');
                    },
                    child: const Text(
                      'Friends',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                  )),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0x00040000),
                  child: TextButton(
                    style: ButtonStyle(alignment: Alignment.centerLeft),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (
                      //       context,
                      //     ) =>
                      //             BlocProvider.value(
                      //               value:
                      //                   BlocProvider.of(context).SocialCubit(),
                      //             )));

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BlocProvider.value(
                              value: BlocProvider.of<SocialCubit>(context),
                              child: SettingsScreen(),
                            );
                          },
                        ),
                      );





                    },
                    child: const Text(
                      'Settings',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                  )),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0x06040000),
                  child: TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8)),
                        alignment: Alignment.centerLeft),
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences
                          .remove('uid')
                          .then((value) => setState(() {}))
                          .then((value) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      });
                    },
                    child: const Text(
                      textAlign: TextAlign.left,
                      'Logout',
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                  )),
            ],
          );
        } else if (state is ProfileInfoErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
