import 'package:TikTok/features/users/models/user_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createProfile(UserProfileModel user) async {}
  //get profile
  //update profileImg
  //update bio
  //update link
}

final userRepo = Provider((ref) => UserRepository());
