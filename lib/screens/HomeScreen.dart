import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:videoplayer/components/selection_card.dart';
import 'package:videoplayer/enums.dart';
import 'package:videoplayer/screens/VideoScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ["mp4", "wav"]
      );
      navigate(result!.files.single.path);
    }catch(e) {
      debugPrint(e.toString());
    }
  }

  selectFolder() async {
    String? result = await FilePicker.platform.getDirectoryPath();
    debugPrint(result);
  }

  void navigate(path){
    Navigator.of(context).push( MaterialPageRoute(
        builder: (context)=> VideoScreen(path: path)
      )
    );
  }

  void networkVideo() async {
    try {
      final result = await InternetAddress.lookup("www.google.com");
      if( result.isNotEmpty && result[0].rawAddress.isNotEmpty ) {
        debugPrint("Connected.");
      }
    }catch(e){
      debugPrint(e.toString());
      debugPrint("Not connected.");
    }
  }

  Widget popUp(){
    return PopupMenuButton<HomePopupOptions>(
        icon: const Icon(Icons.more_vert_rounded),
        itemBuilder: (context) => <PopupMenuEntry<HomePopupOptions>>[
          const PopupMenuItem<HomePopupOptions>(
            value: HomePopupOptions.LoadAll,
            child: Text("Load All Videos"),
          ),
          const PopupMenuItem<HomePopupOptions>(
            value: HomePopupOptions.LoadAll,
            child: Text("Load All Folders"),
          )
        ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Player"),
        actions: [
          popUp(),
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            GestureDetector(
              onTap: (){ selectFile(); },
              child: const SelectionCard(
                  icon: Icons.add,
                  text:"Open Video File"
              ),
            ),
            GestureDetector(
              onTap: (){
                networkVideo();
              },
              child: const SelectionCard(
                  icon: Icons.network_cell,
                  text:"Play Network Video"
              ),
            ),
            GestureDetector(
              onTap: (){
                selectFolder();
              },
              child: const SelectionCard(
                  icon: Icons.folder,
                  text:"Open Folder"
              ),
            )
          ],
        ),
      )
    );
  }
}
