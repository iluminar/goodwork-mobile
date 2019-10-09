import 'package:goodwork/models/task.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState {
  const HomeState();
}

class InitialHomeState extends HomeState {}

class CurrentWorkLoaded extends HomeState {
  const CurrentWorkLoaded({this.currentWork});

  final List<Task> currentWork;
}
