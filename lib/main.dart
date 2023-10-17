import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/Controllers/FoodProvider.dart';
import 'package:provider/provider.dart';
import 'Controllers/OrderDataProvider.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/OrderScreen.dart';
import 'Utils/Routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FoodProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderDataProvider(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food App',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
                elevation: 0.4,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.dark),
                color: Colors.white,
                toolbarHeight: 44,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            textTheme: const TextTheme(
              titleLarge: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
              bodyLarge: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
              bodySmall: TextStyle(
                  fontSize: 8,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400),
              bodyMedium: TextStyle(
                  fontSize: 11,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
            ),
          ),
          routes: {
            Navigator.defaultRouteName: (context) => const HomeScreen(),
            orderScreen: (context) => const OrderScreen()
          },
        );
      },
    );
  }
}
