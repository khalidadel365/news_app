import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState){
            uId = state.uid;
            CacheHelper.saveData(
                key: 'uId',
                value: state.uid);
            navigateAndFinish(context, NewsLayout());
          }else if(state is LoginErrorState){
            showToast(
                state: ToastStates.ERROR,
                message: 'Email or Password may be incorrect'
            );
          }
        },
        builder: (context,state){
          return Scaffold(
            body: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom:15.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: defaultColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: Text(
                              'Sign in for exclusive news and real-time updates',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.text,
                              label: 'Email Address',
                              prefix: Icons.email,
                              validate: (value){
                                if(value.isEmpty){
                                  return 'Email must not be empty';
                                }
                                return null;
                              },
                
                          ),
                          SizedBox(height: screenHeight*0.025),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: 'Password',
                            prefix: Icons.password,
                            validate: (value){
                              if (value.isEmpty){
                                return 'Password must not be empty';
                              }
                              return null;
                            },
                            suffix: LoginCubit.get(context).suffix,
                            suffixPressed: (){
                              LoginCubit.get(context).changePasswordVisibility();
                            },
                            obsecureText: LoginCubit.get(context).isPassword? true : false,
                            onSubmit: (value){
                              // if(formKey.currentState!.validate()){
                              //   LoginCubit.get(context).userLogin(
                              //       email: emailController.text,
                              //       password: passwordController.text
                              //   );
                              // }
                            },
                          ),
                          SizedBox(height: screenHeight*0.05),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context)=>defaultButton(
                              text: 'Login',
                              onPressed: (){
                                if(formKey.currentState!.validate()){
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                            ),
                            fallback: (context)=>Center(child: CircularProgressIndicator(color:defaultColor,)),
                          ),
                          SizedBox(height: screenHeight*0.05),
                          Row(
                            children: [
                              Text(
                                'Don\'t have an account ?',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15
                                ),
                              ),
                              defaultTextButton(
                                function: (){
                               navigateTo(context: context,nextScreen: RegisterScreen());
                                },
                                text: 'Register now',
                              )
                            ],
                          )
                        ],
                      ),
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