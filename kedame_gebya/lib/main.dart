import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedame_gebya/bloc/kedame_gebya_bloc.dart';
import 'package:kedame_gebya/routes.dart';
import 'package:kedame_gebya/views/history.dart';
import 'package:kedame_gebya/views/home.dart';
import 'package:kedame_gebya/views/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KedameGebyaBloc(),
      child: MaterialApp(
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => const HomePage(),
          Routes.profile: (context) => const ProfilePage(),
          Routes.history: (context) => const HistoryPage(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
