import 'package:flutter/material.dart';
import 'package:sqfilte_todo/models/task_model.dart';
import 'package:sqfilte_todo/screens/update_task_screen.dart';
import 'package:sqfilte_todo/shered/components/defualt_form_fields.dart.dart';
import 'package:sqfilte_todo/shered/components/remove_task_dialog.dart';
import 'package:sqfilte_todo/shered/cubit/cubit.dart';

Widget buildTask({
  required context,
  required TaskModel model,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * .169,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              blurRadius: 15.0,
              color: Colors.black12,
              offset: Offset(0, 5),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: chooseTaskColor(model.taskTag),
                radius: 10.0,
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.taskName,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        model.taskDesc,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 18.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Text(
                          model.taskDeadLine,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '#${model.taskTag}',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: chooseTaskColor(model.taskTag),
                          ),
                        ),
                        // const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<int>(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onSelected: (item) {
                  if (item == 0) {
                    // print(model.toJson());
                    TodoCubit.get(context).setCurrentTask = model;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateScreen(),
                      ),
                    );
                  }
                  if (item == 1) {
                    showDialog(
                      context: context,
                      builder: (context) => removeTaskDialog(context, model.id),
                    );
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text(
                      'Update',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              Checkbox(
                value: model.taskStatus != 'new',
                onChanged: (value) {
                  TodoCubit.get(context).markTaskAsCompleted(
                      model: TaskModel(
                          id: model.id,
                          taskName: model.taskName,
                          taskStatus:
                              model.taskStatus == 'new' ? 'done' : 'new',
                          taskTag: model.taskTag,
                          taskDesc: model.taskDesc,
                          taskDeadLine: model.taskDeadLine));
                },
              ),
            ],
          ),
        ),
      ),
    );
