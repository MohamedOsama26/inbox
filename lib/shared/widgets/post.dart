import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:inbox/shared/widgets/resize_text_feild.dart';
// import 'package:flutter/services.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

void submittedEffect(BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        decoration: BoxDecoration(
          color: const Color(0x8C000000),
          borderRadius: BorderRadius.circular(50)
        ),
        margin: const EdgeInsets.symmetric(horizontal : 16.0),
        height: 50,
        child: const Center(
          child: Text('D o n e  \u{1F609}',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xDAFFFFFF)
            ),
          ),
        ),
      ),
      duration: Duration(seconds: 1),
    ),
  );
}

class _PostState extends State<Post> {
  List<String> images = [
    'https://cairoict.b-cdn.net/wp-content/uploads/2021/05/CairoICT-2020-0000105.jpg',
    'https://lh3.googleusercontent.com/u/1/drive-viewer/AFDK6gOJbeDbEqs7sv2ecWkbnT7e7elOIRHMnJg6u4JTnFF9sf1jU9yiaEZW-0glgC322DbF_L6x24N2_CRFoHQyPx0OvLS6=w1848-h968',
    'https://cairoict.b-cdn.net/wp-content/uploads/2021/05/CairoICT-2020-0000112.jpg'
  ];

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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 34.0,
                    backgroundImage: NetworkImage(
                      'https://lh3.googleusercontent.com/u/1/drive-viewer/AFDK6gPA2aa7pJPjxae4DMKZFtgNOl7RhZzzoUMB1-Sd-uUsKIEraseFPCGNVMF-WBYtty7YmTTV0azYWhxjGw3uNykwWx8sXA=w1848-h995',
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Mohamed Osama',
                      style: TextStyle(
                          color: Color(0xA6000000),
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      '3rd Nov. 2021, 13:30',
                      style: TextStyle(
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
            //Images swiper in the post
            SizedBox(
              height: 200,
              child: Swiper(
                pagination: const SwiperPagination(),
                viewportFraction: 0.9,
                scale: 0.92,
                loop: false,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF2C3036)),
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x99000000),
                          ),
                        ],
                        image: DecorationImage(
                            image: NetworkImage(images[index]),
                            fit: BoxFit.cover)),
                  );
                },
                itemCount: 3,
              ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            //Text content in the post
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                children: const [
                  Text(
                      'Cairo ICT is built around creating targeted exposure with theme-specific technologies to enable exhibitors showcase products/services to a highly motivated targeted audience in a unique business environment. ')
                ],
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
                  TextButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        minimumSize: const Size(3, 2)),
                    onPressed: () => print('like'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.favorite_border,
                          // color: Colors.blue,
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          '201',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
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
                    const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 24.0,
                      backgroundImage: NetworkImage(
                        'https://lh3.googleusercontent.com/u/1/drive-viewer/AFDK6gPA2aa7pJPjxae4DMKZFtgNOl7RhZzzoUMB1-Sd-uUsKIEraseFPCGNVMF-WBYtty7YmTTV0azYWhxjGw3uNykwWx8sXA=w1848-h995',
                      ),
                    ),
                    const SizedBox(
                      width: 2.0,
                    ),
                    Expanded(
                      child:
                          ResizeTextField(commentController: commentController,multiLine: true,
                             padding: EdgeInsets.symmetric(vertical: 4,horizontal: 2)
                          ),
                    ),
                    const SizedBox(
                      width: 2.0,
                    ),
                    CircleAvatar(
                        child: IconButton(
                      onPressed: () {
                        if(commentController.text.isNotEmpty) {
                          FocusScope.of(context).unfocus();
                          submittedEffect(context);
                          commentController.clear();
                        }else{
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
