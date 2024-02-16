import 'dart:io';

import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:TikTok/features/videos/view_models/timeline_vm.dart';
import 'package:TikTok/features/videos/view_models/upload_video_view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoUploadForm extends ConsumerStatefulWidget {
  final XFile video;

  const VideoUploadForm({required this.video, super.key});

  @override
  VideoUploadFormState createState() => VideoUploadFormState();
}

class VideoUploadFormState extends ConsumerState<VideoUploadForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final description = "";
  final title = "";

  @override
  void initState() {
    super.initState();
  }

  void _onUploadPressed() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    ref
        .read(uploadVideoProvider.notifier)
        .uploadVideo(File(widget.video.path), title, description, context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Video',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        actions: [
          TextButton(
            onPressed: ref.watch(timelineProvider).isLoading
                ? () {}
                : _onUploadPressed,
            child: ref.watch(uploadVideoProvider).isLoading
                ? const CircularProgressIndicator()
                : const Text(
                    'Upload',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Title",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Gaps.h16,
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 240,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        onSubmitted: (_) => _onUploadPressed(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Gaps.h16,
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 240,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        onSubmitted: (_) => _onUploadPressed(),
                        maxLines: 3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
