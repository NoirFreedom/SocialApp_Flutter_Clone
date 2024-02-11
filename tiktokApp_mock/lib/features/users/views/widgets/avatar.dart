import 'dart:io';
import 'package:TikTok/features/users/view_models/avatar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends ConsumerWidget {
  final String name;
  final bool hasAvatar;
  final String uid;
  final bool isTapEnabled; // 추가된 부분

  const Avatar({
    super.key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
    this.isTapEnabled = true,
  });

  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLodding = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      onTap: (isLodding || !isTapEnabled) ? null : () => _onAvatarTap(ref),
      child: isLodding
          ? Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(),
            )
          : CircleAvatar(
              radius: 50,
              foregroundImage: hasAvatar
                  ? NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/sns-project-a.appspot.com/o/avatars%2F$uid?alt=media&haha=${DateTime.now().toString()}')
                  : null,
              child: const Text("name"),
            ),
    );
  }
}
