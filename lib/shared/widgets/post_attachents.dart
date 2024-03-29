import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class PostAttachments extends StatelessWidget {
  PostAttachments({Key? key, required this.postImage}) : super(key: key);

  final List<String> images = [
    'https://cairoict.b-cdn.net/wp-content/uploads/2021/05/CairoICT-2020-0000105.jpg',
    'https://lh3.googleusercontent.com/u/1/drive-viewer/AFDK6gOJbeDbEqs7sv2ecWkbnT7e7elOIRHMnJg6u4JTnFF9sf1jU9yiaEZW-0glgC322DbF_L6x24N2_CRFoHQyPx0OvLS6=w1848-h968',
    'https://cairoict.b-cdn.net/wp-content/uploads/2021/05/CairoICT-2020-0000112.jpg'
  ];

  final String postImage;

  @override
  Widget build(BuildContext context) {
    return //Images swiper in the post
        SizedBox(
            child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      constraints: const BoxConstraints(
        maxHeight: 300,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(postImage),
          fit: BoxFit.fitWidth,
        ),
      ),
    ));
  }
}
