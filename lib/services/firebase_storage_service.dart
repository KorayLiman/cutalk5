import 'dart:io';

import 'package:ctlk2/services/storage_base.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService implements StorageBase {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late firebase_storage.Reference ref;

  @override
  Future<String> uploadFile(String userId, String fileType, File file) async {
    ref =
        storage.ref().child(userId).child(fileType).child("Profile_photo.png");
    UploadTask uploadTask = ref.putFile(file);
    String url = await (await uploadTask).ref.getDownloadURL();

    return url;
  }
}
