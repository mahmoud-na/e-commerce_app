import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_app/cubit/states.dart';
import 'package:todo_app/models/shop_app/shop_app_home_model.dart';
import 'package:todo_app/modules/shop_app/categories/categories_screen.dart';
import 'package:todo_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:todo_app/modules/shop_app/products/products_screen.dart';
import 'package:todo_app/modules/shop_app/settings_screen/settings_screen.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/network/end_points.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screensList = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> navBarIconsList = [];

  void changeBottomNavBarState(int index) {
    currentIndex = index;
    emit(ChangeShopBottomNavIndexState());
  }

   HomeModel? homeModel;

  void getHomeData() {
    emit(ShopHomeDataLoadingState());

    DioHelper.getData(
      url: HOME,
      authorization: token,
    ).then((value) {

      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel.data.banners[4].id);
      // print(homeModel.data.banners[0]);

      emit(ShopHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeDataErrorState(error.toString()));
    });
  }
}
