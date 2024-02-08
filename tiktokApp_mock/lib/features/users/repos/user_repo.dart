import 'dart:io';

import 'package:TikTok/features/users/models/user_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<void> uploadAvatar(File file, String filename) async {
    final fileRef = _storage.ref().child("avatars/$filename");
    await fileRef.putFile(file);
  }
  //update bio
  //update link
}

final userRepo = Provider((ref) => UserRepository());
