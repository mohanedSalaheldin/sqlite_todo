import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqfilte_todo/screens/tags_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:sqfilte_todo/models/task_model.dart';
import 'package:sqfilte_todo/screens/notes_screen.dart';
import 'package:sqfilte_todo/shered/cubit/states.dart';

class TodoCubit extends Cubit<TodoStates> {
  late Database _database;

  TodoCubit() : super(TodoInitialState()) {
    openMyDatabase(); // Initialize database when TodoCubit is created
  }

  static TodoCubit get(context) => BlocProvider.of<TodoCubit>(context);

  List screens = [
    const NotesScreen(),
    const DoneTasksScreen(),
  ];

  int currentIndex = 0;

  void changeBottomNavBarItem(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  TaskModel? _currentTask;

  set setCurrentTask(TaskModel model) {
    _currentTask = model;
  }

  TaskModel? get getCurrentTask => _currentTask;

  Future<void> openMyDatabase() async {
    print('Opening database...');
    _database = await openDatabase(
      p.join(await getDatabasesPath(), 'tasks_database.db'),
      onCreate: (db, version) async {
        await db
            .execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, taskName TEXT, taskDesc TEXT, taskTag TEXT, taskStatus TEXT,taskDeadLine TEXT)',
        )
            .catchError((error) {
          print('Failed to creating table: $error');
        });
        print('Table created');
      },
      onOpen: (db) {
        print('Database opened');
        getTasks(db);
      },
      version: 1,
    );
// Fetch tasks after opening the database
  }

  Future<void> addTask({required TaskModel model}) async {
    emit(AddTaskLoadingState());
    try {
      await _database.transaction((txn) async {
        final taskId = await txn.rawInsert(
          'INSERT INTO tasks (taskName, taskDesc, taskTag, taskStatus, taskDeadLine) VALUES (?, ?, ?, ?,?)',
          [
            model.taskName,
            model.taskDesc,
            model.taskTag,
            model.taskStatus,
            model.taskDeadLine
          ],
        );
        print('Task inserted with ID: $taskId');
        getTasks(_database); // Refresh tasks after adding a new task
        emit(AddTaskSuccessState());
      });
    } catch (error) {
      print('Failed to insert task: $error');
      emit(AddTaskErrorState());
    }
  }

  void editTask({required TaskModel model}) {
    emit(UpdateTaskLoadingState());
    try {
      _database.rawUpdate('''
    UPDATE tasks 
    SET 
      taskName = ?,
      taskStatus = ?,
      taskTag = ?,
      taskDesc = ?,
      taskDeadLine = ?
    WHERE id = ?
  ''', [
        model.taskName,
        model.taskStatus,
        model.taskTag,
        model.taskDesc,
        model.taskDeadLine,
        model.id,
      ]);
      print('Task updated with ID: ${model.id}');
      getTasks(_database); // Refresh tasks after adding a new task
      emit(UpdateTaskSuccessState());
    } catch (error) {
      print('Failed to update task: $error');
      emit(UpdateTaskErrorState());
    }
  }

  void markTaskAsCompleted({required TaskModel model}) {
    emit(MakeTaskDoneLoadingState());
    try {
      _database.rawUpdate('''
    UPDATE tasks 
    SET 
      taskName = ?,
      taskStatus = ?,
      taskTag = ?,
      taskDesc = ?,
      taskDeadLine = ?
    WHERE id = ?
  ''', [
        model.taskName,
        model.taskStatus,
        model.taskTag,
        model.taskDesc,
        model.taskDeadLine,
        model.id,
      ]);
      print('Task updated with ID: ${model.id}');
      getTasks(_database); // Refresh tasks after adding a new task
      emit(MakeTaskDoneSuccessState());
    } catch (error) {
      print('Failed to update task: $error');
      emit(MakeTaskDoneErrorState());
    }
  }

  Future<void> deleteTask({required int taskId}) async {
    emit(DeleteTaskLoadingState());
    try {
      await _database.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
      print('Task deleted with ID: $taskId');
      getTasks(_database); // Refresh tasks after adding a new task
      emit(DeleteTaskSuccessState());
    } catch (error) {
      print('Failed to delete task: $error');
      emit(DeleteTaskErrorState());
    }
  }

  Future<void> getTasks(Database db) async {
    emit(GetTasksLoadingState());
    try {
      final List<Map<String, dynamic>> taskMaps =
          await db.rawQuery('SELECT * FROM tasks');
      print(taskMaps.toString());
      _tasks = taskMaps.map((taskMap) => TaskModel.fromJson(taskMap)).toList();
      emit(GetTasksSuccessState());
    } catch (error) {
      print('Failed to fetch tasks: $error');
      emit(GetTasksErrorState());
    }
  }
}
