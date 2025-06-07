import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_school/widget/my_button.dart';
import 'package:task_school/widget/my_text_form.dart';
import 'package:task_school/widget/skill_level_menu.dart';

import 'app_cubit/app_cubit.dart';
import 'app_cubit/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: BlocProvider(
        create: (context) => AppCubit()..getAllData(),
        child: MultiBlocListener(
          listeners: [
            BlocListener<AppCubit, AppState>(
              listenWhen: (previous, current) => previous.appStatus != current.appStatus,
              listener: (context, state) {
                if (state.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data inserted successfully!')),
                  );
                }
                if (state.isError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage!)),
                  );
                }
              },
            ),
            BlocListener<AppCubit, AppState>(
              listenWhen: (previous, current) => previous.getAllStateStatus != current.getAllStateStatus,
              listener: (context, state) {
                if (state.isGetAllStateSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data fetched successfully!')),
                  );
                }
                if (state.isGetAllStateError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage!)),
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final AppCubit cubit = context.read<AppCubit>();
              return Form(
                key: cubit.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter Your Data',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      MyTextFormField(
                        controller: cubit.nameController,
                        label: 'Name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      MyTextFormField(
                        controller: cubit.emailController,
                        label: 'Email',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      MyTextFormField(
                        controller: cubit.instrumentController,
                        label: 'Instrument',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Instrument';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SkillLevelMenu(cubit: cubit),
                      const SizedBox(height: 20),
                      state.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.pinkAccent,
                              ),
                            )
                          : MyButton(
                              onTap: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.insertData();
                                }
                              },
                            ),
                      const SizedBox(height: 20),
                      const Text(
                        'All Data',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      state.getAllStateStatus == GetAllStateStatus.loading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.pinkAccent,
                              ),
                            )
                          : state.students == null || state.students!.isEmpty
                          ? const Center(child: Text('No data found'))
                          : Expanded(
                            child: ListView.builder(
                                itemCount: state.students?.length,
                                itemBuilder: (context, index) {
                                  final student = state.students![index];
                                  return Card(
                                    elevation: 2,
                                    child: ListTile(
                                      title: Text(student.instrument),
                                      subtitle: Text(student.skillLevel),
                                      trailing: Text(student.name),
                                    ),
                                  );
                                },
                              ),
                          ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

