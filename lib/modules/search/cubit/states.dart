abstract class SearchStates {}

class SearchInitialState extends SearchStates{}

class NewsSearchSuccessState extends SearchStates{}
class NewsSearchLoadingState extends SearchStates{}

class NewsSearchErrorState extends SearchStates{
  late final String error;
  NewsSearchErrorState(this.error);
}