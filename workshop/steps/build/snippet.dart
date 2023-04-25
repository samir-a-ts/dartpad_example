import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// Вообще без понятия зачем лол
  RendererBinding.instance.scheduleWarmUpFrame();

  runApp(const AppWidget());
}

abstract class AppRoutes {
  static const splash = '/splash';
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ru'),
      title: 'Моё приложение!',
      routes: {
        AppRoutes.splash: (context) => const SplashPage(),
      },
      initialRoute: AppRoutes.splash,
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello, world!'),
      ),
    );
  }
}
