import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/layout/shop_app/shop_app_layout.dart';
import 'package:todo_app/modules/shop_app/login/cubit/states.dart';
import 'package:todo_app/modules/shop_app/register/shop_register_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginScreenStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status == true) {
              print('=======================================');
              print(state.loginModel.data?.token);
              print('=======================================');
              print(state.loginModel.message);
              print('=======================================');

              showToast(
                msg: '${state.loginModel.message}',
                state: ToastStates.SUCCESS,
              );
              CacheHelper.saveData(
                key: "token",
                value: state.loginModel.data?.token,
              ).then((value) => navigateAndReplace(context, const ShopLayout()));

            } else {
              print('=======================================');
              print(state.loginModel.message);
              print('=======================================');
              showToast(
                msg: '${state.loginModel.message}',
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeAppThemeMode();
                  },
                  icon: const Icon(
                    Icons.dark_mode,
                  ),
                ),
              ],
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          textEditingController: emailController,
                          textInputType: TextInputType.emailAddress,
                          labelText: 'Email Address',
                          prefixIcon: const Icon(Icons.email_outlined),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email Address must be not empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          textEditingController: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibilityState();
                            },
                            icon: ShopLoginCubit.get(context).suffix,
                          ),
                          enableInteractiveSelection: true,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          obscureText:
                              ShopLoginCubit.get(context).isPasswordVisible,
                          prefixIcon: const Icon(Icons.lock_outline),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (BuildContext context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              text: 'Register',
                              onPressed: () {
                                navigateTo(
                                  context,
                                  const ShopRegisterScreen(),
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
