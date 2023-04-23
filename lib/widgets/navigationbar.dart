// import 'package:flutter/material.dart';
// import 'package:zooapp/screens/homescreen.dart';
// import 'package:zooapp/screens/tourprogramscreen.dart';

// class RootNav extends StatefulWidget {
//   const RootNav({super.key});

//   @override
//   State<RootNav> createState() => _RootNavState();
// }

// class _RootNavState extends State<RootNav> {
//   int currentPageIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: NavigationBar(
//         onDestinationSelected: (int index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//         selectedIndex: currentPageIndex,
//         destinations: const <Widget>[
//           NavigationDestination(
//             icon: Icon(Icons.explore),
//             label: 'Explore',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.commute),
//             label: 'Commute',
//           ),
//           NavigationDestination(
//             selectedIcon: Icon(Icons.bookmark),
//             icon: Icon(Icons.bookmark_border),
//             label: 'Saved',
//           ),
//         ],
//       ),
//       body: [HomeScreen(), TourProgramScreen(), HomeScreen()][currentPageIndex],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:zooapp/screens/homescreen.dart';
import 'package:zooapp/screens/tourprogramscreen.dart';
import 'package:zooapp/widgets/custompageroute.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({Key? key}) : super(key: key);

  @override
  _MyNavBarState createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  int currentPageIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    TourProgramScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
        print("aktualny index " + index.toString());
        // [print("jeden"), print("dwa"), print("trzy")][currentPageIndex];
        switch (currentPageIndex) {
          case 0:
            Navigator.push(
                context, CustomPageRoute(builder: (context) => HomeScreen()));
            break;
          case 1:
            Navigator.push(context,
                CustomPageRoute(builder: (context) => TourProgramScreen()));
            break;
          case 2:
            Navigator.push(
                context, CustomPageRoute(builder: (context) => HomeScreen()));
            break;
        }
        setState(() {
          currentPageIndex = index;
        });
      },
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
        NavigationDestination(
          icon: Icon(Icons.commute),
          label: 'Commute',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.bookmark),
          icon: Icon(Icons.bookmark_border),
          label: 'Saved',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.bookmark),
          icon: Icon(Icons.bookmark_border),
          label: 'Saved',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.bookmark),
          icon: Icon(Icons.bookmark_border),
          label: 'Saved',
        ),
      ],
    );
  }
}
