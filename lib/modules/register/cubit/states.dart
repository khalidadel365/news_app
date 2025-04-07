
abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{

}
class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState(this.error);
}

class CreateUserSuccessState extends RegisterStates{
  final String uid;
  CreateUserSuccessState(this.uid);
}
class CreateUserLoadingState extends RegisterStates{}
class CreateUserErrorState extends RegisterStates{
  final error;
  CreateUserErrorState(this.error);
}
class RegisterPasswordVisibilityState extends RegisterStates{}
