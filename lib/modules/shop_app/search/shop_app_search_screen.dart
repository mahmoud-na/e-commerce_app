import 'package:flutter/material.dart';

class ShopAppSearchScreen extends StatelessWidget {
  const ShopAppSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Search SCREEN',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
