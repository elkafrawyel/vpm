import 'package:flutter/material.dart';

class ValetScreen extends StatefulWidget {
  const ValetScreen({super.key});

  @override
  State<ValetScreen> createState() => _ValetScreenState();
}

class _ValetScreenState extends State<ValetScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Valet'),
    );
  }
}
