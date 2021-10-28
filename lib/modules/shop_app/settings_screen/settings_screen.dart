import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(
        'Settings SCREEN',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
