import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/components/constants.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/login_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return  BlocProvider(
      create: (context)=> RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is CreateUserSuccessState){
            uId = state.uid;
            CacheHelper.saveData(
                key: 'uId',
                value: state.uid);
            navigateAndFinish(context, NewsLayout());
          }
          else if(state is CreateUserErrorState){
            showToast(
                state: ToastStates.ERROR,
                message: 'some input is incorrect'
            );
          }
        },
        builder: (context,state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom:10.0),
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: defaultColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 35.0),
                            child: Text(
                              'Join the news community – it’s free!',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          defaultFormField(
                            controller: nameController,
                            type: TextInputType.text,
                            label: 'User Name',
                            validate: (value){
                              if(value.isEmpty){
                                return 'user name must not be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: screenHeight*0.025,
                          ),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.text,
                            label: 'Email Address',
                            validate: (value){
                              if(value.isEmpty){
                                return 'email must not be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: screenHeight*0.025,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: 'Password',
                            obsecureText: RegisterCubit.get(context).isPassword,
                            suffix: RegisterCubit.get(context).suffix,
                            suffixPressed: (){
                              RegisterCubit.get(context).changePasswordVisibility();
                            },
                            validate: (value){
                              if(value.isEmpty){
                                return 'password must not be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height:  screenHeight*0.025,
                          ),
                          defaultFormField(
                            controller: phoneController,
                            type: TextInputType.number,
                            label: 'Phone Number',
                            validate: (value){
                              if(value.isEmpty){
                                return 'phone number must not be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: screenHeight*0.05,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context)=> defaultButton(
                                text: 'SIGN UP',
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    RegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text);
                                  }
                                }),
                            fallback: (context)=> Center(child: CircularProgressIndicator(color: defaultColor,)),
                
                          ),
                          SizedBox(
                            height: screenHeight*0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                " Already have an account?",
                                // style: Theme.of(context).textTheme.bodyText1
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                                ),),
                              defaultTextButton(function: (){
                                navigateTo(
                                    context: context,
                                    nextScreen: LoginScreen(),
                                  fullScreen: true,
                                );
                              }, text: 'SIGN IN')
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