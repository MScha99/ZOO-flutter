import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zooapp/widgets/sql_helper.dart';
import 'package:zooapp/screens/homescreen.dart';
import 'package:zooapp/screens/testowa.dart';
import 'package:zooapp/screens/tourprogramscreen.dart';
import 'package:zooapp/screens/searchscreen.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  // final database = SQLHelper();
  // final program = await database.getProgram();
  // print(program);
  bool useMaterial3 = true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'ZOO Wrocław',
      theme: ThemeData(colorSchemeSeed: Color(0xFFF5ECE4)
          // This is the theme of your application.
          ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////
/// poniżej deklaracja goRoutera i routów do całej aplikacji
////////////////////////////////////////////////////////////////////////////
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        print(state.location);
        return NoTransitionPage(
            child: ScaffoldWithNavBar(
          location: state.location,
          child: child,
        ));
      },
      routes: [
        GoRoute(
            path: '/home',
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: HomeScreen(),
              );
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'testowa',
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: TestowaScreen(),
                  );
                },
              )
            ]),
        GoRoute(
          path: '/achievements',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: Scaffold(
                body: Center(child: Text("tu bedzie strona z osiagnieciami")),
              ),
            );
          },
        ),
        GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/map',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: Scaffold(
                  body: Center(child: Text("tu bedzie strona z mapą")),
                ),
              );
            }),
        GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/program',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: TourProgramScreen(),
              );
            }),
        GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/search',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: SearchScreen(),
              );
            }),
      ],
    ),
  ],
);

/////////////////////////////////////////////////////////////////////////
/// poniżej deklaracja bottomNavigationBar, jest to scaffold który w swoim body
/// wyświetla child który jest zwracany przez dany route
////////////////////////////////////////////////////////////////////////////
class ScaffoldWithNavBar extends StatefulWidget {
  String location;
  ScaffoldWithNavBar({super.key, required this.child, required this.location});

  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int _currentIndex = 2;

  static const List<MyCustomBottomNavBarItem> tabs = [
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.emoji_events_outlined),
      activeIcon: Icon(Icons.emoji_events),
      label: 'achiev',
      initialLocation: '/achievements',
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.map_outlined),
      activeIcon: Icon(Icons.map),
      label: 'DISCOVER',
      initialLocation: '/map',
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'SHOP',
      initialLocation: '/home',
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.content_paste_outlined),
      activeIcon: Icon(Icons.content_paste),
      label: 'program',
      initialLocation: '/program',
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.search_outlined),
      activeIcon: Icon(Icons.search),
      label: 'program',
      initialLocation: '/search',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontFamily: 'Roboto');
    int currently;
    switch (widget.location) {
      case '/achievements':
        currently = 0;
        break;
      case '/map':
        currently = 1;
        break;
      case '/home':
        currently = 2;
        break;
      case '/program':
        currently = 3;
        break;
      case '/search':
        currently = 4;
        break;
      default:
        currently = 2;
        break;
    }
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF5ECE4),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xFF434343),
        selectedFontSize: 12,
        unselectedItemColor: const Color(0xFF838383),
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _goOtherTab(context, index);
        },
        currentIndex: currently,
        items: tabs,
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = tabs[index].initialLocation;

    setState(() {
      _currentIndex = index;
    });

    router.go(location);
  }
}

class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const MyCustomBottomNavBarItem(
      {required this.initialLocation,
      required Widget icon,
      String? label,
      Widget? activeIcon})
      : super(icon: icon, label: label, activeIcon: activeIcon ?? icon);
}
