import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqfilte_todo/bloc_observer.dart';
import 'package:sqfilte_todo/layout/home_layout.dart';
import 'package:sqfilte_todo/shered/cubit/cubit.dart';
import 'package:sqfilte_todo/shered/styles/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: MaterialApp(
        theme: lightTheme(),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        home: const HomeLayout(),
      ),
    );
  }
}
