import 'package:flutter/material.dart';

import '../app_cubit/app_cubit.dart';

class SkillLevelMenu extends StatelessWidget {
  const SkillLevelMenu({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: cubit.selectedSkillLevel,
      items: cubit.skillLevels.map((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      onChanged: (value) {
        cubit.selectedSkillLevel = value!;
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a Skill Level';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Skill Level',
        border: OutlineInputBorder(),
      ),
    );
  }
}
