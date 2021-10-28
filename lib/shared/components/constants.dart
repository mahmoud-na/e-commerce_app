/*
  * Get
  *
  * base url : https://newsapi.org/
  * method (url): v2/everything?
  * queries : q=tesla&from=2021-09-18&sortBy=publishedAt
  *
*/

//https://newsapi.org/v2/everything?q=tesla&from=2021-09-18&sortBy=publishedAt&apiKey=aa29a31083924d0d834cd6cf632653f8



import 'package:todo_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';

import 'components.dart';

void signOut(context) => CacheHelper.removeData(key: 'token').then(
      (value) => CacheHelper.removeData(key: 'onBoarding').then(
        (value) => navigateAndReplace(
          context,
          ShopLoginScreen(),
        ),
      ),
    );


void printFullText(String text){
  final pattern =RegExp('.{1,800}');

  pattern.allMatches(text).forEach((match)=>print(match.group));

}

String? token;