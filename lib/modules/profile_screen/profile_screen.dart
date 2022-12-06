import 'package:flutter/material.dart';
import 'package:inbox/modules/login_screen/login_screen.dart';
import 'package:inbox/shared/links.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                // radius: 15.0,
                backgroundImage: NetworkImage(profilePicture),
              ),
            ),
            // Image.network(
            //   backgroundProfilePicture,
            // ),
            // Container(
            //   child: Positioned(
            //     bottom: -50,
            //     child: CircleAvatar(
            //       backgroundColor: Colors.white,
            //       radius: 50.0,
            //       child: CircleAvatar(
            //         radius: 45.0,
            //         backgroundImage: NetworkImage(profilePicture),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
        const Text(
          'Mohamed Osama Kandil',
          style:
              TextStyle(height: 2, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const Text(
          'Try to be perfect \u{1F44C}',
          style: TextStyle(
              height: 2,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xE2383838)),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    print('1');
                  },
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
                    onTap: () {
                      print('2');
                    },
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
                  onTap: () {
                    print('3');
                  },
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
                    onTap: () {
                      print('4');
                    },
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
        TextButton(
          onPressed: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences
                .remove('uid')
                .then((value) => setState(() {}))
                .then((value) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
              print(preferences.get('uid'));
            });
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}
