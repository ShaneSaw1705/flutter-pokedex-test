import 'package:flutter/cupertino.dart';
import 'package:iospokemonflutter/pages/index.dart';

void main() {
  runApp(const app());
}

class app extends StatefulWidget {
  const app({super.key});

  @override
  State<app> createState() => _appState();
}

class _appState extends State<app> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: Home(),
    );
  }
}
