import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fambb_mobile/pages/analytics.dart';
import 'package:fambb_mobile/pages/home.dart';
import 'package:fambb_mobile/pages/settings.dart';
import 'package:fambb_mobile/pages/shortcuts.dart';
import 'package:fambb_mobile/pages/authorization.dart';
import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/data/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  return runApp(const App());
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final EdgeInsets pagePadding = const EdgeInsets.all(16.0);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chart_bar), label: 'Analytics'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_grid_2x2), label: 'Shortcuts'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings), label: 'Settings'),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) => const HomePage(),
            );
          case 1:
            return CupertinoTabView(
              builder: (context) => const AnalyticsPage(),
            );
          case 2:
            return CupertinoTabView(
              builder: (context) => const ShortcutsPage(),
            );
          case 3:
            return CupertinoTabView(
              builder: (context) => const SettingsPage(),
            );
          default:
            return CupertinoTabView(
              builder: (context) => const HomePage(),
            );
        }
      },
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  Future<bool> _isAuthenticated() async {
    const storage = FlutterSecureStorage();
    final secret = await storage.read(key: "userSecret");

    if (secret == null) {
      return false;
    }

    // Verify secret with backend
    User? user = await ApiService().fetchUser();
    if (user == null) {
      // Clear storage if the secret is invalid
      await storage.delete(key: "userSecret");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: "Family Finances",
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemYellow, // Strong accent color
        primaryContrastingColor:
            CupertinoColors.systemYellow, // Additional contrasting color
        barBackgroundColor: CupertinoColors
            .darkBackgroundGray, // Background for navigation bars
        scaffoldBackgroundColor:
            Color(0xFF1C1C1E), // Darker background for the app
        textTheme: CupertinoTextThemeData(
          primaryColor:
              Color(0xFFE5E5E5), // Lighter text for better readability
          textStyle: TextStyle(
            fontFamily: 'FiraCode',
            fontWeight: FontWeight.w300,
            fontSize: 18,
            color: Color(0xFFF5F5F5), // Softer white for general text
          ),
        ),
      ),
      home: FutureBuilder(
        future: _isAuthenticated(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoActivityIndicator();
          }
          if (snapshot.data == true) {
            return const RootPage();
          }
          return const AuthPage();
        },
      ),
      builder: (context, child) {
        return DefaultTextStyle(
          style: const TextStyle(
            fontFamily: 'FiraCode',
            fontWeight: FontWeight.w300,
            fontSize: 18,
            color: CupertinoColors.white,
          ),
          child: child!,
        );
      },
    );
  }
}
