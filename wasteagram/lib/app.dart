import 'package:flutter/material.dart';
import 'screens/entry_lists_screen.dart';
import 'screens/new_post_screen.dart';
import 'screens/post_details_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  static final routes = {
    EntryListsScreen.routeName: (context) => const EntryListsScreen(),
    NewPostScreen.routeName: (context) => const NewPostScreen(),
    PostDetailsScreen.routeName: (context) => PostDetailsScreen()
  };

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: App.routes,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
