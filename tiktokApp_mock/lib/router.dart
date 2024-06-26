import 'package:TikTok/common/%08views/main_navigation_screen.dart';
import 'package:TikTok/features/authentication/views/login_screen.dart';
import 'package:TikTok/features/authentication/repos/authentication_repo.dart';
import 'package:TikTok/features/authentication/views/sign_up_sceen.dart';
import 'package:TikTok/features/inbox/views/activity_screen.dart';
import 'package:TikTok/features/inbox/views/chat_detail_screen.dart';
import 'package:TikTok/features/inbox/views/chats_screen.dart';
import 'package:TikTok/features/inbox/views/userList_screen.dart';
import 'package:TikTok/features/notifications/notifications_provider.dart';
import 'package:TikTok/features/onboarding/interests_screen.dart';
import 'package:TikTok/features/users/views/user_profile_edit.dart';
import 'package:TikTok/features/videos/views/video_recording_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
        initialLocation: "/home",
        redirect: (context, state) {
          final isLoggedIn = ref.read(authRepo).isLoggedIn;
          if (!isLoggedIn) {
            if (state.subloc != SignUpScreen.routeURL &&
                state.subloc != LoginScreen.routeURL) {
              return SignUpScreen.routeURL;
            }
          }
          return null;
        },
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              ref.read(notificationsProvider(context));
              return child;
            },
            routes: [
              GoRoute(
                path: SignUpScreen.routeURL,
                name: SignUpScreen.routeName,
                builder: (context, state) => const SignUpScreen(),
                routes: const [],
              ),
              GoRoute(
                path: LoginScreen.routeURL,
                name: LoginScreen.routeName,
                builder: (context, state) => const LoginScreen(),
              ),
              GoRoute(
                path: InterestsScreen.routeURL,
                name: InterestsScreen.routeName,
                builder: (context, state) => const InterestsScreen(),
              ),
              GoRoute(
                path: "/:tab(home|discover|inbox|profile)",
                name: MainNavigationScreen.routeName,
                builder: (context, state) {
                  final tab = state.params["tab"]!;
                  return MainNavigationScreen(
                    tab: tab,
                  );
                },
              ),
              GoRoute(
                path: ActivityScreen.routeURL,
                name: ActivityScreen.routeName,
                builder: (context, state) => const ActivityScreen(),
              ),
              GoRoute(
                path: ChatsScreen.routeURL,
                name: ChatsScreen.routeName,
                builder: (context, state) => const ChatsScreen(),
                routes: [
                  GoRoute(
                    path: ChatDetailScreen.routeURL,
                    name: ChatDetailScreen.routeName,
                    builder: (context, state) {
                      final chatId = state.params["chatId"]!;
                      final friendName = state.queryParams["friendName"] ?? "";
                      return ChatDetailScreen(
                        chatId: chatId,
                        friendName: friendName,
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: UserListScreen.routeURL,
                name: UserListScreen.routeName,
                builder: (context, state) => const UserListScreen(),
              ),
              GoRoute(
                path: VideoRecordingScreen.routeURL,
                name: VideoRecordingScreen.routeName,
                pageBuilder: (context, state) => CustomTransitionPage(
                  transitionDuration: const Duration(milliseconds: 100),
                  child: const VideoRecordingScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    final position =
                        Tween(begin: const Offset(0, 1), end: Offset.zero)
                            .animate(animation);
                    return SlideTransition(
                      position: position,
                      child: child,
                    );
                  },
                ),
              ),
              GoRoute(
                path: UserProfileEditScreen.routeURL,
                name: UserProfileEditScreen.routeName,
                builder: (context, state) => const UserProfileEditScreen(),
              ),
            ],
          ),
        ]);
  },
);
