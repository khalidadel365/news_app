abstract class NewsStates {}

class NewsInitialState extends NewsStates{}

class NewsChangeBotttomNavBar extends NewsStates{}

class NewsGetBusinessSuccessState extends NewsStates{}
class NewsGetBusinessLoadingState extends NewsStates{}
class NewsGetBusinessErrorState extends NewsStates{
  late final String error;
  NewsGetBusinessErrorState(this.error);
}
class NewsGetSportsSuccessState extends NewsStates{}
class NewsGetSportsLoadingState extends NewsStates{}
class NewsGetSportsErrorState extends NewsStates{
  late final String error;
  NewsGetSportsErrorState(this.error);
}
class NewsGetScienceSuccessState extends NewsStates{}
class NewsGetScienceLoadingState extends NewsStates{}
class NewsGetScienceErrorState extends NewsStates{
  late final String error;
  NewsGetScienceErrorState(this.error);
}
class GetUserDataLoadingState extends NewsStates{}
class GetUserDataSuccessState extends NewsStates{}
class GetUserDataErrorState extends NewsStates{
  late final String error;
  GetUserDataErrorState(this.error);
}
class LogOutLoadingState extends NewsStates{}
class LogOutSuccessState extends NewsStates{}
class LogOutErrorState extends NewsStates{
  late final String error;
  LogOutErrorState(this.error);
}