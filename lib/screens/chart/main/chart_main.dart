import 'package:flutter/material.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chart Screen Huxley'),
      ),
      body: const Center(
        child: Text('Chart Screen'),
      ),
    );
  }
}
