import 'package:flutter/material.dart';

class Circularprogression extends StatelessWidget {
  const Circularprogression({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}