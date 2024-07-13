import 'dart:io';
import 'package:LactoSafe/src/model/info_food_model.dart';
import 'package:LactoSafe/src/shared/app_camera_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadImage(File imageFile, BuildContext context) async {
  try {
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    Reference ref =
        FirebaseStorage.instance.ref().child("food_images/$fileName");
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('food_images')
        .add({'url': downloadURL});

    if (context.mounted) {
      Navigator.popAndPushNamed(context, '/foodlist', arguments: downloadURL);
    }

    return downloadURL;
  } catch (e) {
    print("Ocorreu um erro ao fazer upload da imagem: $e");
    return null;
  }
}

abstract class Picture {
  void takePicture(
      {required BuildContext context, required CameraSource sourceType});
}

class CameraFoodPicture implements Picture {
  @override
  void takePicture(
      {required BuildContext context, required CameraSource sourceType}) async {
    XFile? image;
    if (sourceType == CameraSource.camera) {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        File userFoodImage = File(image.path);
        String? imageURL = await uploadImage(userFoodImage, context);
        if (imageURL != Null) {
          print("Imagem carregada com sucesso");
        } else {
          print("Falha no upload");
        }
        if (context.mounted) {
          Navigator.popAndPushNamed(context, '/foodlist',
              arguments: File(image.path));
        }
      }
    } else {
      throw UnimplementedError("Ocorreu um erro. Tente novamente.");
    }
  }
}

class GalleryFoodPicture implements Picture {
  @override
  void takePicture(
      {required BuildContext context, required CameraSource sourceType}) async {
    XFile? image;
    if (sourceType == CameraSource.gallery) {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        File userFoodImage = File(image.path);
        String? imageURL = await uploadImage(userFoodImage, context);
        if (imageURL != Null) {
          print("Imagem Carregada com Sucesso");
        } else {
          print("Falha no Upload");
        }

        if (context.mounted) {
          Navigator.popAndPushNamed(context, '/foodlist',
              arguments: File(image.path));
        }
      }
    } else {
      throw UnimplementedError("Ocorreu um erro. Tente novamente.");
    }
  }
}
