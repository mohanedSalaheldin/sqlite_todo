import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqfilte_todo/models/task_model.dart';
import 'package:sqfilte_todo/shered/components/task_widget.dart';
import 'package:sqfilte_todo/shered/cubit/cubit.dart';
import 'package:sqfilte_todo/shered/cubit/states.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {
        if (state is AddTaskSuccessState) {
          Fluttertoast.showToast(msg: 'Task added successfuly');
        }
        if (state is AddTaskErrorState) {
          Fluttertoast.showToast(msg: 'Task add failed');
        }
        if (state is UpdateTaskSuccessState) {
          Fluttertoast.showToast(msg: 'Task updated successfuly');
        }
        if (state is UpdateTaskSuccessState) {
          Fluttertoast.showToast(msg: 'Task update failed');
        }
        if (state is DeleteTaskSuccessState) {
          Fluttertoast.showToast(msg: 'Task  deleted successfuly');
        }
        if (state is DeleteTaskErrorState) {
          Fluttertoast.showToast(msg: 'Task delet failed');
        }
      },
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.get(context);
        List<TaskModel> tasks = cubit.tasks;
        if (state is GetTasksLoadingState ||
            state is AddTaskLoadingState ||
            state is UpdateTaskLoadingState ||
            state is DeleteTaskLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (tasks.isEmpty && state is GetTasksSuccessState) {
          return const Center(
            child: Text('No Tasks'),
          );
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                // var model = tasks[];
                return buildTask(
                  context: context,
                  model: tasks[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10.0,
                );
              },
              itemCount: tasks.length,
            ),
          ),
          //  buildTask(context: context),
        );
      },
    );
  }
}
