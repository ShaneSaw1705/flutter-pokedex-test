import 'package:flutter/cupertino.dart';
import 'package:iospokemonflutter/pages/homepage.dart';
import 'package:iospokemonflutter/pages/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house),
              activeIcon: Icon(CupertinoIcons.house_fill)),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              activeIcon: Icon(CupertinoIcons.person_fill)),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gear_big),
            activeIcon: Icon(CupertinoIcons.gear_solid),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) => const Homepage());
          case 1:
            return CupertinoTabView(builder: (context) => const Settings());
          case 2:
            return CupertinoTabView(builder: (context) => const Settings());
          default:
            return Container();
        }
      },
    );
  }
}
