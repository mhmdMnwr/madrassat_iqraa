import 'package:flutter/material.dart';

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wait Page'),
      ),
      body: Center(
        child: Text('You must wait'),
      ),
    );
  }
}
