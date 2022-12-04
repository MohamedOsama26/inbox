import 'package:flutter/material.dart';
import 'package:inbox/shared/links.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ReelsScreen extends StatefulWidget {
  const ReelsScreen({Key? key}) : super(key: key);

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {



  // String getUrl ()async{
  //
  //   Reference ref = FirebaseStorage.instance.ref().child("/2022-11-29 15-35-28.mkv");
  //   await ref.getDownloadURL().then((_){
  //     return _.toString();
  //   }).catchError((_){
  //     return 'ERROR $_';
  //   });
  //   return '';
  //   // String link = url.toString();
  //   // print(link);
  //   // return link;
  // }

  // late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerController;
  //
  // @override
  // void initState(){
  //   _controller = VideoPlayerController.network('https://static.videezy.com/system/resources/previews/000/012/730/original/Palm_Trees_07_-_4K_res.mp4');
  //   _controller.addListener(() {
  //     setState(() {});
  //   });
  //   _initializeVideoPlayerController = _controller.initialize().then((value) => setState((){}));
  //   _controller.setLooping(true);
  //   _controller.setVolume(1.0);
  //   _controller.play();
  //   super.initState();
  //   print(_initializeVideoPlayerController);
  // }
  //
  // @override
  // void dispose(){
  //   _controller.dispose();
  //   super.dispose();
  //
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.network(
  //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
  //     ..initialize().then((value) => setState(() {}));
  // }
  final VideoPlayerController _controller = VideoPlayerController.network(
      zombieSongLink,
  );
  late Future<void> _initializeVideoPlayerFuture;

  // _controller =
  // _initializeVideoPlayerFuture = ;

  @override
  void initState() {

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    // _controller.setVolume(1.0).then((value) => setState((){}));

    _controller.play().then((value) => setState(
          () {},
        ));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Widget builder() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          print(
              '========================= ${MediaQuery.of(context).size.width}');
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(
                    _controller,
                  ),
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
    // return CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('\u{1FAE3}'),
        Container(
          height: 200,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            height: 100,
            // child: ListView.separated(
            //   scrollDirection: Axis.horizontal,
            //   itemBuilder: (context, index) {
            //     return Container(
            //       margin: index == 0 ? EdgeInsets.only(left: 8): EdgeInsets.zero,
            //       width: 140,
            //       child: builder(),ch
            //       decoration: BoxDecoration(
            //       ),
            //       padding: EdgeInsets.all(4),
            //     );
            //   },
            //   separatorBuilder: (context, index) {
            //     return SizedBox(
            //       width: 10,
            //     );
            //   },
            //   itemCount: 3,
            // ),
          ),
        ),
      ],
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }
}
