import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personal/helpers/app_theme.dart';
import 'package:personal/pages/entry/login.dart';
import 'package:personal/pages/personal_home.dart';
import 'package:personal/services/auth_services.dart';
import 'package:personal/services/expense_service.dart';
import 'package:personal/services/user_ops_services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ///
        /// Auth providers
        ///
        Provider(
          create: (context) =>
              AuthServices(firebaseAuth: FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthServices>().authState,
          initialData: null,
        ),

        ///
        /// User providers
        ///
        Provider(
          create: (context) => FirebaseFirestore.instance,
        ),
        Provider(
          create: (context) => UserOpsServices(
              firebaseFirestore: context.read<FirebaseFirestore>()),
        ),

        /// Expense privder
        Provider(create: (context) => ExpenseService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: //ThemeData.dark(),
            // used in home.dart
            ThemeData(
          cardTheme: CardTheme(
            color: Colors.purple[100],
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          popupMenuTheme: PopupMenuThemeData(
            color: MyAppThemeProperties.backGroundColor,
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
            elevation: 20,
          ),
          // used in dd_fuel_page.dart
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.normal,
            buttonColor: MyAppThemeProperties.actionColor,
          ),
          // used all over the app
          scaffoldBackgroundColor: Colors.deepOrange[50],
          appBarTheme: AppBarTheme(
            backgroundColor: MyAppThemeProperties.backGroundColor,
            // MyAppThemeProperties.backGroundColor,
            titleTextStyle: MyAppThemeProperties.titleTextColor,
            elevation: 0.0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),

          dividerColor: Colors.blueGrey,
          primarySwatch: MyAppThemeProperties.actionColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});
  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User?>();
    if (firebaseuser != null) {
      return const PersonalHome();
    } else {
      return const Login();
    }
  }
}
