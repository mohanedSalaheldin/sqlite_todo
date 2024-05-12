import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqfilte_todo/models/task_model.dart';
import 'package:sqfilte_todo/shered/components/add_task_dialog.dart';
import 'package:sqfilte_todo/shered/components/defualt_form_fields.dart.dart';
import 'package:sqfilte_todo/shered/cubit/cubit.dart';
import 'package:sqfilte_todo/shered/cubit/states.dart';

class UpdateScreen extends StatelessWidget {
  TaskModel? model;
  final _updateFormKey = GlobalKey<FormState>();
  String selectedUpdateValue = '';
  var taskUpdateController = TextEditingController();
  var descriptionUpdateController = TextEditingController();
  var deadlineUpdateController = TextEditingController();
  var tagUpdateController = TextEditingController();

  UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TodoCubit.get(context);
        model = cubit.getCurrentTask;
        if (model != null) {
          taskUpdateController.text = model!.taskName;
          descriptionUpdateController.text = model!.taskDesc;
          tagUpdateController.text = model!.taskTag;
          deadlineUpdateController.text = model!.taskDeadLine;
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Update Task',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _updateFormKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          defaultUpdateTextform(
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Task name can\'t be empty';
                              }

                              return null;
                            },
                            controller: taskUpdateController,
                            label: 'Task',
                            icon: Icons.task_outlined,
                          ),
                          defaultUpdateTextform(
                            validation: (p0) {
                              return null;
                            },
                            controller: descriptionUpdateController,
                            label: 'Description',
                            icon: Icons.article_outlined,
                          ),
                          defaultUpdateTextform(
                            validation: (p0) {
                              return null;
                            },
                            controller: deadlineUpdateController,
                            label: 'Deadline',
                            keyboardType: TextInputType.none,
                            icon: Icons.calendar_month,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2026),
                              ).then((value) {
                                deadlineUpdateController.text =
                                    DateFormat.yMMMMd('en_US').format(value!);
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              children: [
                                const Icon(Icons.discount_outlined, size: 30.0),
                                const SizedBox(width: 15.0),
                                Expanded(
                                  child: DropdownButtonFormField2<String>(
                                    value: tagUpdateController.text,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsetsDirectional.symmetric(
                                        horizontal: 20,
                                        vertical: 32,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    hint: const Text(
                                      'Tag',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    items: items
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    validator: (value) {
                                      return null;
                                    },
                                    onChanged: (value) {
                                      tagUpdateController.text = value!;
                                    },
                                    onSaved: (value) {
                                      selectedUpdateValue = value.toString();
                                    },
                                    buttonStyleData: const ButtonStyleData(),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 24,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 2,
                                        vertical: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const Spacer(),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey),
                          ),
                          child: const Text(
                            'Cancel',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_updateFormKey.currentState!.validate()) {
                              cubit.editTask(
                                  model: TaskModel(
                                id: model!.id,
                                taskName: taskUpdateController.text,
                                taskTag: tagUpdateController.text,
                                taskDesc: descriptionUpdateController.text,
                                taskStatus: model!.taskStatus,
                                taskDeadLine: deadlineController.text,
                              ));
                              taskUpdateController.text = '';
                              descriptionUpdateController.text = '';
                              tagUpdateController.text = '';
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Save',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
