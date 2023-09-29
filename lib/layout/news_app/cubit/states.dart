abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBotttomNavBar extends NewsStates{}

class NewsGetBusinessLoadingState extends NewsStates{}

class NewsGetBusinessSuccessState extends NewsStates{}
class AppChangeModeState extends NewsStates{}


class NewsGetBusinessErrorState extends NewsStates{
  String? error;
  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates{}

class NewsGetSearchLoadingState extends NewsStates{}
class NewsGetSearchSuccessState extends NewsStates{}
class NewsGetSearchErrorState extends NewsStates{
  String? error;
  NewsGetSearchErrorState(this.error);
}

class NewsGetSportsSuccessState extends NewsStates{}

class NewsGetSportsErrorState extends NewsStates{
  String? error;
  NewsGetSportsErrorState(this.error);
}
class NewsGetScienceLoadingState extends NewsStates{}

class NewsGetScienceSuccessState extends NewsStates{}

class NewsGetScienceErrorState extends NewsStates{
  String? error;
  NewsGetScienceErrorState(this.error);
}