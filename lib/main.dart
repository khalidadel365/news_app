import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/cubit/states.dart';
import 'layout/news_app/news_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(myApp(isDark));
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class myApp extends StatelessWidget{
  bool? isDark;
  myApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()..changeAppMode(
            fromShared: isDark
        )),
        //Blocprovider...
      ],
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false ,
            home:  AnimatedSplashScreen(
              splash: Lottie.asset('assets/images/news_splash.json'),
              duration: 2600,
              splashIconSize: 300,
              backgroundColor: NewsCubit.get(context).isDark? Colors.white:HexColor('333739'),
              splashTransition: SplashTransition.fadeTransition,
              nextScreen: NewsLayout(),
            ),
            theme: NewsLightTheme,
            darkTheme: NewsDarkTheme,
            themeMode: NewsCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
          );
        },
      ),
    );

  }
}





// *********************NewsAppSplashScreen*************************************



