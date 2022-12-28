import 'package:finalbookapp/Constants/products_model.dart';
import 'package:finalbookapp/Providers/Firebase%20Authentication/firebase_auth_provider.dart';
import 'package:finalbookapp/Providers/Firebase%20Authentication/firebase_storage_provider.dart';
import 'package:finalbookapp/Providers/Firebase%20Authentication/user_provider.dart';
import 'package:finalbookapp/Screens/Authentication/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedStorage.init();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => FirebaseLoginProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => FirebaseStorageAPI(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WrapperAuth(),
    );
  }
}
