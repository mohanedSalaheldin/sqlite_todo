import 'package:flutter/material.dart';
import 'package:sqfilte_todo/shered/cubit/cubit.dart';

Widget removeTaskDialog(context, int taskId) => Center(
      child: AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        title: const Text('Delete?'),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey[200],
                    ),
                  ),
                  onPressed: () {
                    print('--------------------------');
                    print(taskId);
                    print('--------------------------');
                    TodoCubit.get(context).deleteTask(taskId: taskId);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        content: SizedBox(
          height: MediaQuery.of(context).size.height * .10,
          width: MediaQuery.of(context).size.width * .50,
          child: const Text('Are you sure?'),
        ),
      ),
    );
