// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(totalCount) => "${totalCount}";

  static String m1(gender) =>
      "Log in ${Intl.gender(gender, female: 'madam', male: 'sir', other: 'plz')}";

  static String m2(nameOfTheApp) => "Login to your ${nameOfTheApp} account.";

  static String m3(videoCount) =>
      "Create a profile, follow other accounts, make your own ${Intl.plural(videoCount, zero: 'no video', one: 'video', other: 'videos')}, and more.";

  static String m4(nameOfTheApp) => "Sign up for ${nameOfTheApp}";

  static String m5(value, value2) =>
      "${value} ${Intl.plural(value2, one: 'comment', other: 'comments')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alreadyHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "likeCount": m0,
        "logIn": m1,
        "loginTitle": m2,
        "signUpSubtitle": m3,
        "signUpTitle": m4,
        "signUpWithApple":
            MessageLookupByLibrary.simpleMessage("Sign up with Apple"),
        "signUpWithFacebook":
            MessageLookupByLibrary.simpleMessage("Sign up with Facebook"),
        "signUpWithGoogle":
            MessageLookupByLibrary.simpleMessage("Sign up with Google"),
        "useEmailPassword":
            MessageLookupByLibrary.simpleMessage("Use Email & Password"),
        "videoCommentCount": m5
      };
}
