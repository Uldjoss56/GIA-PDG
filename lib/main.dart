import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/services/notifications_service.dart';
import 'package:gia_pdg_partenaire/ui/begin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then((_) {
    runApp(const ProviderScope(
      child: MainApp(),
    ));      
  });
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDG-Partner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: myPink,
        ),
        textTheme: const TextTheme().copyWith(
          titleMedium: const TextStyle(
            fontFamily: "Manrope",
            color: myPink,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
          headlineLarge: const TextStyle(
            fontFamily: "Manrope",
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: myGrisFonce,
          ),
          displayLarge: const TextStyle(
            fontFamily: "Manrope",
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          displayMedium: const TextStyle(
            fontFamily: "Manrope",
            fontSize: 15,
          ),
          labelSmall: const TextStyle(
            fontFamily: "Manrope",
            color: Colors.black,
            fontSize: 11,
          ),
          labelMedium: const TextStyle(
            fontFamily: "Manrope",
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        useMaterial3: true,
      ),
      home: const Begin(),
      debugShowCheckedModeBanner: false,
    );
  }
}
