import 'package:todo_app/models/shop_app/shop_login_model.dart';

abstract class ShopLoginScreenStates {}

class ShopLoginInitialState extends ShopLoginScreenStates {}

class ShopLoginLoadingState extends ShopLoginScreenStates {}

class ShopLoginSuccessState extends ShopLoginScreenStates {
  final ShopLoginModel loginModel;
  ShopLoginSuccessState({required this.loginModel});
}

class ShopLoginErrorState extends ShopLoginScreenStates {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopLoginChangeVisibilityState extends ShopLoginScreenStates {}
