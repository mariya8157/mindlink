import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../main.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({super.key});

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  File? _videoFile;
  VideoPlayerController? _videoController;
  final ImagePicker _picker = ImagePicker();

  // Method to pick a video from the gallery
  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _videoController = VideoPlayerController.file(_videoFile!)
          ..initialize().then((_) {
            setState(() {}); // Update the state to refresh the UI
            _videoController!.play(); // Auto-play the selected video
          });
      });
    }
  }

  // Method to share the video file
  void _shareVideo() {
    if (_videoFile != null) {
      Share.shareXFiles([XFile(_videoFile!.path)], text: 'Check out this video!');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No video selected to share')),
      );
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height*0.5,
                width: width*0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width*0.03)
                ),
                child: _videoFile != null && _videoController!.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
                )
                    : Center(child: const Text('No video selected')),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickVideo,
                child: const Text('Select Video'),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _shareVideo,
                icon: const Icon(Icons.share),
                label: const Text('Share Video'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
