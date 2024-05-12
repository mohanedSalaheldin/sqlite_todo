import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqfilte_todo/shered/components/add_task_dialog.dart';
import 'package:sqfilte_todo/shered/cubit/cubit.dart';
import 'package:sqfilte_todo/shered/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todoy'),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.changeBottomNavBarItem(value);
            },
            items: const [
              BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  Icons.list_alt_outlined,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  Icons.done_outline,
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => buildAddTaskDialog(context: context),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
