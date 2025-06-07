import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key, required this.onTap,
  });
  final Function onTap ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.pinkAccent,
        ),
        alignment: Alignment.center,
        child: const Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}