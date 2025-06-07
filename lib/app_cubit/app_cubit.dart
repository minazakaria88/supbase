import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/student_model.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController instrumentController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> skillLevels = ['Beginner', 'Intermediate', 'Advanced', 'Expert'];
  String? selectedSkillLevel;

  final _supabase = Supabase.instance.client;

  void insertData() async {
    emit(state.copyWith(appStatus: InsertStateStatus.loading));
    try {
      await _supabase.from('students').insert({
        'name': nameController.text,
        'email': emailController.text,
        'instrument': instrumentController.text,
        'skill_level': selectedSkillLevel,
      });
      clearForm();
      emit(state.copyWith(appStatus: InsertStateStatus.success));
      getAllData();
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          appStatus: InsertStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  clearForm() {
    nameController.clear();
    emailController.clear();
    instrumentController.clear();
    selectedSkillLevel = null;
  }


  void dispose() {
    nameController.dispose();
    emailController.dispose();
    instrumentController.dispose();
  }


  void getAllData() async {
    emit(state.copyWith(getAllStateStatus: GetAllStateStatus.loading));
    try {

      List<Student> students = [];
      final response = await _supabase.from('students').select();
      response.map((e) => students.add(Student.fromJson(e))).toList();
      emit(state.copyWith(
        getAllStateStatus: GetAllStateStatus.success,
       students: students,
      ));


      log(response.toString());
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
        getAllStateStatus: GetAllStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    dispose();
    return super.close();
  }

}
