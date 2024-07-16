import 'package:harmony_hive/pages/provider/audio_player_provider.dart';
import 'package:harmony_hive/utils/globals.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'backend/firebase/firebase_config.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await initFirebase();

  await FlutterFlowTheme.initialize();

  //initilizng audio Player provider
  sl.registerLazySingleton(() => AudioPlayerProvider());

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Harmony Hive',
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: const ScrollbarThemeData(),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scrollbarTheme: const ScrollbarThemeData(),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.initialPage, this.page});

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'HomePage';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': const HomePageWidget(),
      'searchPage': const SearchPageWidget(),
      'favPage': const FavPageWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    final MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      body: MediaQuery(
          data: queryData
              .removeViewInsets(removeBottom: true)
              .removeViewPadding(removeBottom: true),
          child: _currentPage ?? tabs[_currentPageName]!),
      extendBody: true,
      // bottomNavigationBar: FloatingNavbar(
      //   currentIndex: currentIndex,
      //   onTap: (i) => setState(() {
      //     _currentPage = null;
      //     _currentPageName = tabs.keys.toList()[i];
      //   }),
      //   backgroundColor: FlutterFlowTheme.of(context).primary,
      //   selectedItemColor: const Color(0xFFF4EFF5),
      //   unselectedItemColor: FlutterFlowTheme.of(context).secondaryText,
      //   selectedBackgroundColor: const Color(0x00000000),
      //   borderRadius: 12.0,
      //   itemBorderRadius: 8.0,
      //   margin: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
      //   padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
      //   width: double.infinity,
      //   elevation: 0.0,
      //   items: [
      //     FloatingNavbarItem(
      //       customWidget: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Icon(
      //             Icons.home_outlined,
      //             color: currentIndex == 0
      //                 ? const Color(0xFFF4EFF5)
      //                 : FlutterFlowTheme.of(context).secondaryText,
      //             size: 28.0,
      //           ),
      //         ],
      //       ),
      //     ),
      //     FloatingNavbarItem(
      //       customWidget: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Icon(
      //             Icons.search_sharp,
      //             color: currentIndex == 1
      //                 ? const Color(0xFFF4EFF5)
      //                 : FlutterFlowTheme.of(context).secondaryText,
      //             size: 28.0,
      //           ),
      //         ],
      //       ),
      //     ),
      //     FloatingNavbarItem(
      //       customWidget: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Icon(
      //             Icons.favorite_border,
      //             color: currentIndex == 2
      //                 ? const Color(0xFFF4EFF5)
      //                 : FlutterFlowTheme.of(context).secondaryText,
      //             size: 28.0,
      //           ),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
