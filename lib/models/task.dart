import 'package:goodwork/models/base_model.dart';
import 'package:meta/meta.dart';

class Task extends BaseModel {
  Task({
    @required this.id,
    @required this.name,
    this.notes,
    this.dueOn,
    this.assignedTo,
    @required this.statusId,
  });

  @override
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      statusId: json['status_id'],
      dueOn: json['due_on'],
    );
  }

  final int id;
  final String name;
  final String notes;
  final String dueOn;
  final int assignedTo;
  final int statusId;

  @override
  List<Object> get props => <dynamic>[];

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'notes': notes,
      'due_on': dueOn,
      'assigned_to': assignedTo,
      'status_id': statusId,
    };
  }
}
