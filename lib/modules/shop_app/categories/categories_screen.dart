import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(
        'Categories SCREEN',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
