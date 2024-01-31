import 'package:crud_firebase/bindings/home_bindings.dart';
import 'package:crud_firebase/firebase_options.dart';
import 'package:crud_firebase/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      initialBinding: HomeBindings(),
      getPages: [
        GetPage(name: "/", page: () => HomePage(), binding: HomeBindings())
      ],
    );
  }
}
