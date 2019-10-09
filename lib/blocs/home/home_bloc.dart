import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:goodwork/blocs/auth/auth_bloc.dart';
import 'package:goodwork/blocs/auth/bloc.dart';
import 'package:goodwork/blocs/home/home_event.dart';
import 'package:goodwork/models/task.dart';
import 'package:goodwork/repositories/task_repository.dart';

import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    this.authBloc,
    this.taskRepository,
  ) {
    authBlocSubscription = authBloc.state.listen((state) {
      if (state is UserLoaded) {
        dispatch(UserLoggedIn());
      }
    });
  }

  final AuthBloc authBloc;
  StreamSubscription authBlocSubscription;
  final TaskRepository taskRepository;

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is UserLoggedIn) {
      try {
        final List<Task> currentWork =
            await taskRepository.getUserCurrentTask();
        yield CurrentWorkLoaded(currentWork: currentWork);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    authBlocSubscription.cancel();
    super.dispose();
  }
}
