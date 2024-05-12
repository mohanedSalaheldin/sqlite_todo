import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqfilte_todo/models/task_model.dart';
import 'package:sqfilte_todo/shered/components/defualt_form_fields.dart.dart';
import 'package:sqfilte_todo/shered/cubit/cubit.dart';

final _formKey = GlobalKey<FormState>();
String selectedValue = '';
var taskController = TextEditingController();
var descriptionController = TextEditingController();
var tagController = TextEditingController();
var deadlineController = TextEditingController();

Widget buildAddTaskDialog({
  required context,
}) =>
    Builder(
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              title: const Center(
                child: Text(
                  'Add Task',
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * .50,
                width: MediaQuery.of(context).size.width * .75,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        defaultTextform(
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Task name can\'t be empty';
                              }

                              return null;
                            },
                            controller: taskController,
                            label: 'Task',
                            icon: Icons.task_outlined),
                        defaultTextform(
                          validation: (p0) {
                            return null;
                          },
                          controller: descriptionController,
                          label: 'Description',
                          icon: Icons.article_outlined,
                        ),
                        defaultTextform(
                          validation: (p0) {
                            return null;
                          },
                          controller: deadlineController,
                          label: 'Deadline',
                          keyboardType: TextInputType.none,
                          icon: Icons.calendar_month,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2026),
                            ).then((value) {
                              deadlineController.text =
                                  DateFormat.yMMMMd('en_US').format(value!);
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              const Icon(Icons.discount_outlined, size: 30.0),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsetsDirectional.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),

                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),

                                    // Add more decoration..
                                  ),
                                  hint: const Text(
                                    'Tag',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  items: items
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item,
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ))))
                                      .toList(),
                                  validator: (value) {
                                    return null;
                                  },
                                  onChanged: (value) {
                                    tagController.text = value!;
                                  },
                                  onSaved: (value) {
                                    selectedValue = value.toString();
                                  },
                                  buttonStyleData: const ButtonStyleData(),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(Icons.arrow_drop_down,
                                        color: Colors.black45),
                                    iconSize: 24,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 0),
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
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                  ),
                  child: const Text(
                    'Cancel',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('--------------------');
                      print(taskController.text);
                      print(descriptionController.text);
                      print(tagController.text);
                      print(deadlineController.text);
                      print('--------------------');
                      TodoCubit.get(context).addTask(
                        model: TaskModel(
                          id: 0,
                          taskName: taskController.text,
                          taskStatus: 'new',
                          taskTag: tagController.text,
                          taskDesc: descriptionController.text,
                          taskDeadLine: deadlineController.text,
                        ),
                      );
                      taskController.text = '';
                      descriptionController.text = '';
                      tagController.text = '';
                      deadlineController.text = '';
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
