import 'package:TikTok/constants/breakpoints.dart';
import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/videos/view_models/playback_config_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.md),
          child: ListView(
            children: [
              SwitchListTile.adaptive(
                value: ref.watch(playbackConfigProvider).muted,
                onChanged: (value) {
                  ref.read(playbackConfigProvider.notifier).setMuted(value);
                },
                title: const Text("Mute video"),
                subtitle: const Text("Video will be muted by default"),
              ),
              SwitchListTile.adaptive(
                value: ref.watch(playbackConfigProvider).autoPlay,
                onChanged: (value) {
                  ref.read(playbackConfigProvider.notifier).setAutoPlay(value);
                },
                title: const Text("Auto play"),
                subtitle: const Text("Video will be auto played by default"),
              ),
              SwitchListTile.adaptive(
                value: false,
                onChanged: (value) {},
                title: const Text("Enable notifications"),
                subtitle: const Text("Subtitle will be here"),
              ),
              CheckboxListTile.adaptive(
                checkColor: Colors.white,
                activeColor: Colors.black,
                value: false,
                onChanged: (value) {},
                title: const Text("Enable notifications"),
                subtitle: const Text("Subtitle will be here"),
              ),
              ListTile(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                  );
                  if (kDebugMode) {
                    print(date);
                  }

                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (kDebugMode) {
                      print(time);
                    }
                    final booking = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                      builder: (context, child) {
                        return Theme(
                            data: ThemeData(
                                appBarTheme: const AppBarTheme(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black)),
                            child: child!);
                      },
                    );
                    if (kDebugMode) {
                      print(booking);
                    }
                  }
                },
                title: const Text("Set My Birthday"),
              ),
              ListTile(
                title: const Text("Log out (iOS)"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text("Are you sure?"),
                      content: const Text("You will be logged out"),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Cancel"),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            ref.read(authRepo).signOut();
                            context.go("/");
                          },
                          isDestructiveAction: true,
                          child: const Text("Log out"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Log out (Android))"),
                textColor: Colors.red,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Are you sure?"),
                      content: const Text("You will be logged out"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Log out"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Log out (iOS / Bottom)"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      title: const Text("Are you sure?"),
                      message: const Text("You will be logged out"),
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Cancel"),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () => Navigator.of(context).pop(),
                          isDestructiveAction: true,
                          child: const Text("Log out"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const AboutListTile(
                applicationVersion: "1.0.0",
                applicationIcon: Icon(Icons.info),
                applicationName: "TikTok Clone",
                applicationLegalese: "All rights reserved",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
