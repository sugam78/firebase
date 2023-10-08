import 'dart:io';

import 'package:all_firebase/Widgets/reusuable_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  File? _image;
  ImagePicker picker = ImagePicker();
  final storage = firebase_storage.FirebaseStorage.instance;
  final DatabaseRef = FirebaseDatabase.instance.ref('Post');
  Future fetchImage()async{
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pickedImage!=null){
        _image = File(pickedImage.path);
      }
      else{

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 200,
              width: 200,
              child: IconButton(
                onPressed: (){
                  fetchImage();
                },
                icon: Center(child:_image!=null? Image.file(_image!.absolute):Icon(Icons.photo)),
              ),
            ),
          ),
          SizedBox(height: 30,),
          ReusuableButton(title: 'Upload', onTap: (){
            final ref = firebase_storage.FirebaseStorage.instance.ref('/foldername'+'1122');
            firebase_storage.UploadTask upload = ref.putFile(_image!.absolute);
            Future.value(upload).then((value) {
              var newUrl = ref.getDownloadURL();
              DatabaseRef.child('1').set({
                'title': newUrl.toString(),
                'id': 1122,
              });
            });
          }),
        ],
      ),
    );
  }
}
