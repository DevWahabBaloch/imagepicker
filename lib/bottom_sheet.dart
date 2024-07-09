import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class CustomBottomSheet extends StatefulWidget {
  final Function(String value, String imageSrouce) callBack;
  const CustomBottomSheet({
    super.key,
    required this.callBack,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  Future pickImageFromGallery({required BuildContext context}) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    log('this is pickedFile $pickedFile');
    setState(
      () {
        if (pickedFile != null) {
          image = pickedFile;
          log('this is image path ${image!.path}.. image $image');
          log('this is file image with file widget ${File(image!.path)}');
          widget.callBack(image!.path, 'Selected From Gallery');
        }
      },
    );
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  Future pickImageFromCamera({required BuildContext context}) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    log('this is pickedFile $pickedFile');
    setState(
      () {
        if (pickedFile != null) {
          image = pickedFile;
          log('this is image path ${image!.path}.. image $image');
          log('this is file image with file widget ${File(image!.path)}');
          widget.callBack(image!.path, 'Selected From Camera');
        }
      },
    );
    if (context.mounted) {
      Navigator.pop(context);
    }
    // if (image == ImageSource.camera) {
    //   Text('Selected from camera');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              pickImageFromGallery(context: context);
            },
            icon: Icon(Icons.browse_gallery_outlined),
            iconSize: 50,
          ),
          SizedBox(
            width: 50,
          ),
          IconButton(
            onPressed: () {
              pickImageFromCamera(context: context);
            },
            icon: Icon(Icons.camera_alt_outlined),
            iconSize: 50,
          ),
        ],
      ),
    );
  }
}
