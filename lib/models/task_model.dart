class TaskModel {
  final int id;
  final String taskName;
  final String taskStatus;
  final String taskTag;
  final String taskDesc;
  final String taskDeadLine;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskStatus,
    required this.taskTag,
    required this.taskDesc,
    required this.taskDeadLine,
  });



  factory TaskModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return TaskModel(
      id: json['id'],
      taskName: json['taskName'],
      taskStatus: json['taskStatus'],
      taskTag: json['taskTag'],
      taskDesc: json['taskDesc'],
      taskDeadLine: json['taskDeadLine'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskName'] = taskName;
    data['taskStaus'] = taskStatus;
    data['taskTag'] = taskTag;
    data['id'] = id;
    data['taskDesc'] = taskDesc;
    data['taskDeadLine'] = taskDeadLine;
    return data;
  }
}
