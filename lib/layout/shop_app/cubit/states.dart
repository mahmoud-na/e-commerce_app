abstract class ShopStates {}


class ShopInitialState extends ShopStates {}

class ShopBottomNavState extends ShopStates {}

class ChangeShopBottomNavIndexState extends ShopStates {}



class ShopHomeDataLoadingState extends ShopStates{}
class ShopHomeDataSuccessState extends ShopStates{}
class ShopHomeDataErrorState extends ShopStates{
  final String error;
  ShopHomeDataErrorState(this.error);
}


class ShopCategoriesDataSuccessState extends ShopStates{}
class ShopCategoriesDataErrorState extends ShopStates{
  final String error;
  ShopCategoriesDataErrorState(this.error);
}





