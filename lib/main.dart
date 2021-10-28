import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_app/cubit/cubit.dart';
import 'package:todo_app/layout/shop_app/shop_app_layout.dart';
import 'package:todo_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:todo_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:todo_app/shared/bloc_observer.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';
import 'package:todo_app/shared/styles/themes.dart';
import 'modules/shop_app/login/cubit/cubit.dart';

Future<void> main() async {
  /*
    *   WidgetsFlutterBinding.ensureInitialized();
    *   When we use async in main we have to call this function to
    *   ensure App initializations will occurs before app starting
  */

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init(
    baseUrl: 'https://student.valuxapps.com/api/',
  );
  await CacheHelper.init();
 late Widget startingScreen;
  bool? isDark = CacheHelper.getData(key: "isDark");
  bool? onBoardingState = CacheHelper.getData(key: "onBoarding");
   token = CacheHelper.getData(key: "token");

  if(onBoardingState!=null){
    if(token!=null){
      startingScreen = ShopLayout();
    }else{
      startingScreen = ShopLoginScreen();
    }
  }else{
    startingScreen = OnBoardingScreen();
  }

  /*
    * 1. Check out master
    * 2. Update master
    * 3. Create branch
    *
  */

  runApp(MyApp(
    isDark: isDark,
    startingScreen: startingScreen,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startingScreen;

  const MyApp({
    Key? key,
    this.isDark,
    this.startingScreen,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..changeAppThemeMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            home: Directionality(
              child: ShopLoginScreen(),
              // textDirection: TextDirection.rtl,
              textDirection: TextDirection.ltr,
            ),
          );
        },
      ),
    );
  }
}
