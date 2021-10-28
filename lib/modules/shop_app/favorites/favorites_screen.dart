import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(
        'Favorites SCREEN',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
