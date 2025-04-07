import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/shared/components/constants.dart';

import '../../modules/business/business_screen.dart';
import '../../modules/science/science_screen.dart';
import '../../modules/sports/sports_screen.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int current_index = 0;
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      label: 'Business',
      icon: Icon(Icons.business_sharp),
    ),
    BottomNavigationBarItem(
      label: 'Sports',
      icon: Icon(Icons.sports_soccer_outlined),
    ),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];
  List<Widget> screens = [BusinessScreen(), SportsScreen(), ScienceScreen()];

  void changeBottomNavBar(index) {
    current_index = index;
    emit(NewsChangeBotttomNavBar());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'us',
            'category': 'business',
            'apiKey': '9faf1f82b52b44e29b06c471b24422de',
          },
        )
        .then((value) {
          business = value?.data['articles'];
          print(business[0]['title']);
          emit(NewsGetBusinessSuccessState());
          //print(value?.data.toString());
          // print(value?.data['articles'][0]['title']);
        })
        .catchError((error) {
          emit(NewsGetBusinessErrorState(error.toString()));
          print(error.toString());
        });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'us',
            'category': 'Sports',
            'apiKey': '9faf1f82b52b44e29b06c471b24422de',
          },
        )
        .then((value) {
          sports = value?.data['articles'];
          print(business[0]['title']);
          emit(NewsGetSportsSuccessState());
          //print(value?.data.toString());
          // print(value?.data['articles'][0]['title']);
        })
        .catchError((error) {
          emit(NewsGetSportsErrorState(error.toString()));
          print(error.toString());
        });
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'us',
            'category': 'science',
            'apiKey': '9faf1f82b52b44e29b06c471b24422de',
          },
        )
        .then((value) {
          science = value?.data['articles'];
          print(business[0]['title']);
          emit(NewsGetBusinessSuccessState());
          //print(value?.data.toString());
          // print(value?.data['articles'][0]['title']);
        })
        .catchError((error) {
          emit(NewsGetBusinessErrorState(error.toString()));
          print(error.toString());
        });
  }

  UserModel userModel = UserModel();

  void getUserData(String uId) {
    emit(GetUserDataLoadingState());
    print('getUserData');
    print(uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          print(value.data());
          userModel = UserModel.fromJson(value.data());
          emit(GetUserDataSuccessState());
        })
        .catchError((error) {
          print(error.toString());
          emit(GetUserDataErrorState(error.toString()));
        });
  }

  void logOut() {
    emit(LogOutLoadingState());
    CacheHelper.removeData(key: 'uId')!
        .then((value) {})
        .then((value) {
          uId = null;
          print(uId);
          emit(LogOutSuccessState());
        })
        .catchError((error) {
          emit(LogOutErrorState(error.toString()));
        });
  }
}
