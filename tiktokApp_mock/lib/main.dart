import 'package:TikTok/features/videos/repos/playback_config_repo.dart';
import 'package:TikTok/features/videos/view_models/playback_config_vm.dart';
import 'package:TikTok/firebase_options.dart';
import 'package:TikTok/generated/l10n.dart';
import 'package:TikTok/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  final preferences = await SharedPreferences.getInstance();
  final repository = PlaybackConfigRepository(preferences);

  runApp(
    ProviderScope(overrides: [
      playbackConfigProvider
          .overrideWith(() => PlaybackConfigViewModel(repository))
    ], child: const SocialNetworkApp()),
  );
}

class SocialNetworkApp extends ConsumerWidget {
  const SocialNetworkApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    S.load(const Locale("en"));
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: 'App Practice',
      localizationsDelegates: const [
        S.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
      ],
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: Typography.blackMountainView,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
          selectionHandleColor: Color(0xFFE9435A),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black87,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
          elevation: 2,
        ),
        tabBarTheme: const TabBarTheme(
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
        listTileTheme: ListTileThemeData(
            iconColor: Colors.grey.shade800, textColor: Colors.grey.shade800),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade900,
        textTheme: Typography.whiteMountainView,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
          selectionHandleColor: Color(0xFFE9435A),
        ),
        primaryColor: const Color(0xFFE9435A),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade800,
          surfaceTintColor: Colors.grey.shade900,
          titleTextStyle: TextStyle(
            color: Colors.grey.shade100,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
          actionsIconTheme: IconThemeData(color: Colors.grey.shade100),
          iconTheme: IconThemeData(color: Colors.grey.shade100),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade800,
          elevation: 2,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade700,
        ),
      ),
    );
  }
}
