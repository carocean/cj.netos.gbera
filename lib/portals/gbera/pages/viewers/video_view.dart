import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  File src;

  VideoView({this.src});

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController controller;
  int _currentActionIndex = 0;
  var start;
  Future<void> _future_waitfor_inited;
  @override
  void initState() {
    controller = VideoPlayerController.file(widget.src);
    controller.addListener(() {
      if (controller.value.isPlaying) {
        if (_currentActionIndex == 1) {
          return;
        }
        setState(() {
          _currentActionIndex = 1;
        });
      } else {
        if (_currentActionIndex == 0) {
          return;
        }
        setState(() {
          _currentActionIndex = 0;
          //检测到结尾必须得停止，否则重定位后会继续播放
          controller.pause().whenComplete(() {
            if (start != null) {
              controller.seekTo(start);
            }
          });
        });
      }
    });
    _future_waitfor_inited=waitfor_inited();

    super.initState();
  }

  @override
  void dispose() {
    _currentActionIndex = 0;
    controller.dispose();
    start = null;
    _future_waitfor_inited=null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(minHeight: 100, minWidth: 100),
          child: FutureBuilder(
            future: _future_waitfor_inited,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if(snapshot.hasError){
                print('video error: ${snapshot.error}');
                return Container(width: 0,height: 0,);
              }
              final Size size = controller.value.size;
              return AspectRatio(
//             aspectRatio: 16 / 9,
//            aspectRatio: 140 / 200,
                aspectRatio: size.width / size.height,
//            aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Align(
              child: IndexedStack(
                index: _currentActionIndex,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.play_circle_outline,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      controller.play();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.pause,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      controller.pause();
                    },
                  )
                ],
              ),
              alignment: Alignment.bottomRight,
            ),
          ),
        )
      ],
    );
  }
  Future<void> waitfor_inited()async{
    await controller.initialize();
    start = controller.value.position;
  }
}
