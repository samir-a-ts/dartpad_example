import 'package:dartpad_flutter/src/pages/root_page.dart';
import 'package:flutter/material.dart';

class DartPadLinkGeneratorApp extends StatelessWidget {
  const DartPadLinkGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RootPage(),
      title: 'DartPad Link Generator',
    );
  }
}
