
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  String? uid;
  LoginSuccessState(this.uid);
}
class LoginErrorState extends LoginStates{
  final error;
  LoginErrorState(this.error);
}
class LoginPasswordVisibilityState extends LoginStates{}
