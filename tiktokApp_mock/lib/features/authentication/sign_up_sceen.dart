import 'package:TikTok/features/authentication/login_screen.dart';
import 'package:TikTok/features/authentication/username_screen.dart';
import 'package:TikTok/features/authentication/view_models/social_auth_view_model.dart';

import 'package:TikTok/generated/l10n.dart';
import 'package:TikTok/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:TikTok/features/authentication/widgets/auth_button.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerWidget {
  static String routeURL = "/";
  static String routeName = "signUp";
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) async {
    context.pushNamed(LoginScreen.routeName);
  }

  void _onEmailSignUpTap(BuildContext context) {
    /* Navigator.of(context).push(
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const UsernameScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offsetAnimation =
                Tween(begin: const Offset(0, -1), end: Offset.zero)
                    .animate(animation);
            final opacityAnimation =
                Tween(begin: 0.0, end: 1.0).animate(animation);
            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: opacityAnimation,
                child: child,
              ),
            );
          }),
    ); */
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (context, orientation) {
        /*
        if (orientation == Orientation.landscape) {
          return const Scaffold(
              body: Center(
                  child: Text(
                      'Please rotate your device to portrait mode to continue')));
        }
        */
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
                child: Column(
                  children: [
                    Gaps.v80,
                    Text(
                      S.of(context).signUpTitle("App"),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Gaps.v20,
                    Text(
                      S.of(context).signUpSubtitle(1),
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: isDarkMode(context)
                            ? Colors.grey.shade300
                            : Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gaps.v40,
                    GestureDetector(
                      onTap: () => _onEmailSignUpTap(context),
                      child: AuthButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.user,
                            size: Sizes.size20,
                          ),
                          text: S.of(context).useEmailPassword),
                    ),
                    Gaps.v16,
                    GestureDetector(
                      onTap: () => ref
                          .read(socialAuthProvider.notifier)
                          .githubSignIn(context),
                      child: const AuthButton(
                          icon: FaIcon(
                            FontAwesomeIcons.github,
                            size: Sizes.size20,
                          ),
                          text: 'Continue with GitHub'),
                    ),
                    Gaps.v16,
                    AuthButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.apple,
                          size: Sizes.size20,
                        ),
                        text: S.of(context).signUpWithApple),
                    Gaps.v16,
                    AuthButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.google,
                          size: Sizes.size20,
                        ),
                        text: S.of(context).signUpWithGoogle),
                    Gaps.v16,
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: isDarkMode(context) ? null : Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: Sizes.size32, bottom: Sizes.size64),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).alreadyHaveAnAccount,
                    style: const TextStyle(
                      fontSize: Sizes.size14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      S.of(context).logIn("human"),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: Sizes.size14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
