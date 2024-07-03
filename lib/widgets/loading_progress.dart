import 'package:flutter/material.dart';

class LoadingProgress extends StatelessWidget {
  const LoadingProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            backgroundColor: Color.fromARGB(255, 222, 9, 20),
            color: Colors.grey,
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }
}
