import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:imagepicker_assignment/bottom_sheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImagePickerAss(),
    );
  }
}

class ImagePickerAss extends StatefulWidget {
  const ImagePickerAss({super.key});

  @override
  State<ImagePickerAss> createState() => _ImagePickerAssState();
}

class _ImagePickerAssState extends State<ImagePickerAss> {
  String source = '';
  // String imagePath = 'assets/placeholder.png';
  String? imagePath;
  // void checking (){
  //   if (imagePath == ImageSource.camera) {
  //     Text('From camera');
  //   } else {
  //     Text('From gallery');
  //   }
  // }

  void openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => CustomBottomSheet(
        callBack: (value, imageSource) {
          log('abcabc function triggered');
          log('abcabc this is value from callback $value');
          imagePath = value;
          source = imageSource;

          log('abcabc this is imagePath $imagePath');
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () => openBottomSheet(),
                child: Card(
                  elevation: 5,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    maxRadius: 50,
                    backgroundImage: imagePath == null
                        ? const AssetImage('assets/placeholder.png')
                        : FileImage(File(imagePath!)) as ImageProvider,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [const Text('Source: '), Text(source)],
          ),
        ],
      ),
    );
  }
}
