import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/register/cubit/states.dart';
import 'package:news_app/modules/search/cubit/states.dart';
import '../../../models/user_model.dart';
import '../../../shared/network/remote/dio_helper.dart';



class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  List<dynamic> search = [];

  void getSearch(String value){
    emit(NewsSearchLoadingState());

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'9faf1f82b52b44e29b06c471b24422de',
        }).then((value){
      search = value?.data['articles'];
      emit(NewsSearchSuccessState());
      //print(value?.data.toString());
      // print(value?.data['articles'][0]['title']);
    }).catchError((error){
      emit(NewsSearchErrorState(error.toString()));
      print(error.toString());
    });
  }
}
