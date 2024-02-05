// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign up for {nameOfTheApp}`
  String signUpTitle(String nameOfTheApp) {
    return Intl.message(
      'Sign up for $nameOfTheApp',
      name: 'signUpTitle',
      desc: 'Title of the sign up page',
      args: [nameOfTheApp],
    );
  }

  /// `Login to your {nameOfTheApp} account.`
  String loginTitle(String nameOfTheApp) {
    return Intl.message(
      'Login to your $nameOfTheApp account.',
      name: 'loginTitle',
      desc: 'Title of the Log in page',
      args: [nameOfTheApp],
    );
  }

  /// `Create a profile, follow other accounts, make your own {videoCount, plural, =0{no video} =1{video} other{videos}}, and more.`
  String signUpSubtitle(num videoCount) {
    return Intl.message(
      'Create a profile, follow other accounts, make your own ${Intl.plural(videoCount, zero: 'no video', one: 'video', other: 'videos')}, and more.',
      name: 'signUpSubtitle',
      desc: '',
      args: [videoCount],
    );
  }

  /// `Use Email & Password`
  String get useEmailPassword {
    return Intl.message(
      'Use Email & Password',
      name: 'useEmailPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with Facebook`
  String get signUpWithFacebook {
    return Intl.message(
      'Sign up with Facebook',
      name: 'signUpWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with Apple`
  String get signUpWithApple {
    return Intl.message(
      'Sign up with Apple',
      name: 'signUpWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with Google`
  String get signUpWithGoogle {
    return Intl.message(
      'Sign up with Google',
      name: 'signUpWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log in {gender, select, male{sir} female{madam} other{plz}}`
  String logIn(String gender) {
    return Intl.message(
      'Log in ${Intl.gender(gender, male: 'sir', female: 'madam', other: 'plz')}',
      name: 'logIn',
      desc: '',
      args: [gender],
    );
  }

  /// `{totalCount}`
  String likeCount(int totalCount) {
    final NumberFormat totalCountNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String totalCountString = totalCountNumberFormat.format(totalCount);

    return Intl.message(
      '$totalCountString',
      name: 'likeCount',
      desc: 'Number of likes',
      args: [totalCountString],
    );
  }

  /// `{value} {value2, plural, =1{comment} other{comments}}`
  String videoCommentCount(int value, num value2) {
    final NumberFormat valueNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String valueString = valueNumberFormat.format(value);

    return Intl.message(
      '$valueString ${Intl.plural(value2, one: 'comment', other: 'comments')}',
      name: 'videoCommentCount',
      desc: 'Number of comments',
      args: [valueString, value2],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
