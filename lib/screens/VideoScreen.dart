import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayer/components/lower_control_panel.dart';

class VideoScreen extends StatefulWidget {
  final String path;

  const VideoScreen({super.key, required this.path});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late final VideoPlayerController _controller;
  bool _isVideoRatio = true;
  double _videoRatio = 1.0;
  
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path)
      )..initialize().then((file) {
        var size = _controller.value.size;
        setState(() {
          _videoRatio = size.width/size.height;
        });
      });
    debugPrint(_videoRatio.toString());
    if(_videoRatio>1.0){
      setOrientation(DeviceOrientation.landscapeLeft);
    }else{
      setOrientation(DeviceOrientation.portraitUp);
    }

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setOrientation(DeviceOrientation orientation){
    SystemChrome.setPreferredOrientations([
      orientation
    ]);
  }

  void rotateScreen(){
    if(MediaQuery.of(context).orientation == Orientation.landscape){
      setOrientation(DeviceOrientation.portraitUp);
    }else {
      setOrientation(DeviceOrientation.landscapeLeft);
    }
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint((MediaQuery.of(context).size.width/MediaQuery.of(context).size.width).toString());
    debugPrint(_videoRatio.toString());
    return PopScope(
        onPopInvokedWithResult: (_, __){
          setOrientation(DeviceOrientation.portraitUp);
        },
        child: Scaffold(
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: AspectRatio(
                        aspectRatio: _isVideoRatio?  _videoRatio: MediaQuery.of(context).size.aspectRatio,
                        child: VideoPlayer(_controller),
                    )
                  ),

                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      child: AppBar(
                        leading: BackButton(
                          onPressed: (){
                            setOrientation(DeviceOrientation.portraitUp);
                            Navigator.of(context).pop();
                          },
                        ),
                        title: const Text("path/to/video.mp4"),
                        backgroundColor: Colors.blueAccent.withOpacity(0.555),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton.filled(
                        tooltip: "Rotate",
                        onPressed: (){
                          rotateScreen();
                        },
                        icon: const Icon(Icons.screen_rotation),
                      ),
                      const SizedBox(height: 25,),
                      IconButton.filled(
                        tooltip: "ratio change",
                        onPressed: (){
                          setState(() {
                            _isVideoRatio = !_isVideoRatio;
                          });
                        },
                        icon: const Icon(Icons.aspect_ratio),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                      left: 0,
                      right: 0,
                      child: LowerControlPanel(
                        onProgressChange: (){},
                        totalTime: _controller.dataSource.length,
                      )
                  )
                ],
              ),
      )
    );
  }
}
