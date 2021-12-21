import 'package:flutter/material.dart';
import 'package:machine_test/providers/provider_home.dart';
import 'package:machine_test/screens/details_screen.dart';
import 'package:machine_test/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>ProviderHome()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
