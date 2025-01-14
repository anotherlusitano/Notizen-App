import 'package:flutter/material.dart';
import 'package:notizen/config/theme.dart';

import 'config/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: "Notizen",
      routerConfig: router,
    );
  }
}
