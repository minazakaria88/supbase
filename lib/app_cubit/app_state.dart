import 'package:task_school/models/student_model.dart';

enum InsertStateStatus { loading, success, error }

enum GetAllStateStatus { loading, success, error }

extension InsertStateStatusX on AppState {
  bool get isLoading => appStatus == InsertStateStatus.loading;
  bool get isSuccess => appStatus == InsertStateStatus.success;
  bool get isError => appStatus == InsertStateStatus.error;
}

extension GetAllStateStatusX on AppState {
  bool get isGetAllStateLoading =>
      getAllStateStatus == GetAllStateStatus.loading;
  bool get isGetAllStateSuccess =>
      getAllStateStatus == GetAllStateStatus.success;
  bool get isGetAllStateError => getAllStateStatus == GetAllStateStatus.error;
}

class AppState {
  InsertStateStatus? appStatus;
  String? errorMessage;
  GetAllStateStatus? getAllStateStatus;
  List<Student>  ? students;
  AppState({this.appStatus, this.errorMessage, this.getAllStateStatus, this.students});

  AppState copyWith({
    InsertStateStatus? appStatus,
    String? errorMessage,
    GetAllStateStatus? getAllStateStatus,
    List<Student>? students
  }) {
    return AppState(
      appStatus: appStatus ?? this.appStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      getAllStateStatus: getAllStateStatus ?? this.getAllStateStatus,
      students: students ?? this.students
    );
  }
}
