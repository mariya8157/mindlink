import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mindlink/feature/detailsAdding/screen/homeScreen.dart';
import 'package:share_plus/share_plus.dart';

class TextPost extends StatefulWidget {
  const TextPost({super.key});

  @override
  State<TextPost> createState() => _TextPostState();
}

class _TextPostState extends State<TextPost> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _sharePost() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      Share.share(text);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter some text to share')),
      );
    }
  }
  // Method to add data to Firestore
  Future<void> addData() async {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      try {
        DocumentReference value =
        await FirebaseFirestore.instance.collection("user").add({
          "text": text,
        });

        await value.update({
          "id": value.id,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data added successfully')),
        );

        // Navigate to HomeScreen after adding data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  HomeScreen(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding data: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter some text to add')),
      );
    }
  }

  // addData(){
  //   FirebaseFirestore.instance.collection("user").add({
  //     "text":_textController.text,
  //
  //   }).then((value){
  //     value.update({
  //       "id":value.id,
  //     });
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write your post here...',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {
              _sharePost();

              // addData();
              //




            },
              child: Column(
                children: [
                  Icon(Icons.share),
              Text('Share'),
                ],
              )

              // onPressed:
              //     addData(),
              // _sharePost,
              // icon: Icon(Icons.share),
              // label: Text('Share'),
            ),
          ],
        ),
      ),
    );
  }
}
