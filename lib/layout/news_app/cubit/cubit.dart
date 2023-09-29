import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import '../../../modules/science/science_screen.dart';
import '../../../modules/sports/sports_screen.dart';
import '../../../modules/business/business_screen.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';

class  NewsCubit extends Cubit<NewsStates>{
   NewsCubit() : super(NewsInitialState());
   static NewsCubit get (context)=>BlocProvider.of(context);

   int currentIndex = 0;
   List<BottomNavigationBarItem> bottomItems =const[
     BottomNavigationBarItem(
         icon: Icon(
             Icons.business,
         ),
        label: 'Business'
     ),
     BottomNavigationBarItem(
         icon: Icon(
           Icons.sports_soccer_outlined,
         ),
         label: 'Sports'
     ),
     BottomNavigationBarItem(
         icon: Icon(
           Icons.science,
         ),
         label: 'Science'
     ),
   ];
   List<Widget> screens =[
     BusinessScreen(),
     SportsScreen(),
     ScienceScreen(),
   ];
   List<dynamic> business=[];
   List<dynamic> sports=[];
   List<dynamic> science=[];
   List<dynamic> search=[];
   ThemeMode appMode = ThemeMode.dark;
   bool isDark = false;
   void changeAppMode({bool? fromShared}){
     if(fromShared!=null){
       isDark=fromShared;
       emit(AppChangeModeState());
     }
     else{
       isDark = !isDark;
       CacheHelper.putBoolean(key: 'isDark', value: isDark)?.then(
               (value) {
             emit(AppChangeModeState());
           });
     }
     //مش هتخش غير لما ارن الapp
   }
   void getSearch (value){
     emit(NewsGetSearchLoadingState());
     DioHelper.getData(
       url:'/v2/everything',
       query: {
         'q':'$value',
         'apiKey':'0c53f0968a1a46f09dd4dd8dfec494cc',
       },
     )?.then((value){
       search = value.data['articles'];
       print("$search");
       emit(NewsGetSearchSuccessState());
     }
     ).catchError((error){
       emit(NewsGetSearchErrorState(error));
       print(error);
     });
   }
   void changeBottomNavBar(int index){
     if(index==1){
       getSports();
     }
     if(index==2){
       getScience();
     }
     currentIndex = index;
     emit(NewsBotttomNavBar());
   }
   void getBusiness(){
     emit(NewsGetBusinessLoadingState());
     DioHelper.getData(
       url:'/v2/top-headlines', // راح لسيكشن الاخبار مثلا
       query: {
         'country':'us', // هنا بقوله business تبع مصر
         'category':'business', // هنا بقوله عاوز من الاخبار business
         //'sortBy':'publishedAt',
         'apiKey':'0c53f0968a1a46f09dd4dd8dfec494cc',
         //'language':'en'
       },
     )?.then((value){
       business = value.data['articles'];
       print("$business");
       emit(NewsGetBusinessSuccessState());
     }
     ).catchError((error){
       emit(NewsGetBusinessErrorState(error.toString()));
       print(error);
     });
   }
   void getSports(){
     emit(NewsGetSportsLoadingState());
     if(sports.length==0){
       DioHelper.getData(
         url:'/v2/top-headlines', // راح لسيكشن الاخبار مثلا
         query: {
           'country':'us', // هنا بقوله business تبع مصر
           'category':'Sports', // هنا بقوله عاوز من الاخبار business
           'sortBy':'publishedAt',
           'apiKey':'0c53f0968a1a46f09dd4dd8dfec494cc',
           'language':'en'
         },
       )?.then((value){
         sports = value.data['articles'];
         print("$sports");
         emit(NewsGetSportsSuccessState());
       }
       ).catchError((error){
         emit(NewsGetSportsErrorState(error.toString()));
         print(error);
       });
     }else{
       emit(NewsGetSportsSuccessState()); //هيبني الlist أللي موجوده اصلا
     }
   }
   void getScience(){
     emit(NewsGetScienceLoadingState());
     if(science.length==0){
       DioHelper.getData(
         url:'/v2/top-headlines', // راح لسيكشن الاخبار مثلا
         query: {
           'country':'us', // هنا بقوله business تبع مصر
           'category':'science', // هنا بقوله عاوز من الاخبار business
           //'sortBy':'publishedAt',
           'apiKey':'0c53f0968a1a46f09dd4dd8dfec494cc',
           //'language':'en'
         },
       )?.then((value){
         science = value.data['articles'];
         print("$science");
         emit(NewsGetScienceSuccessState());
       }
       ).catchError((error){
         emit(NewsGetScienceErrorState(error.toString()));
         print(error);
       });
     }else{
       emit(NewsGetScienceSuccessState());
     }
   }

}