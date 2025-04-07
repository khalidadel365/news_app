import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/login/login_screen.dart';
import '../modules/search/search_screen.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    print(screenWidth);
    print(screenHeight);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>NewsCubit()..getBusiness()..getSports()..getScience()..getUserData(uId!),)
    ],
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state) {
          var cubit = NewsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                    onPressed: (){
                      navigateTo(
                        context: context,
                        nextScreen: SearchScreen(),);
                }, icon: Icon(
                  Icons.search,
                  color: defaultColor,
                ),
                ),
              ],
              title: Text(
                  'News App',style: TextStyle(
                fontSize: screenWidth*0.05
              ),
                  ),
            ),
            drawer: Drawer(
              width: screenWidth*0.55,
              child: ListView(
                children:  [
                  DrawerHeader(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${cubit.userModel.name}',style: TextStyle(
                              fontSize: 20
                            ),
                            ),
                            SizedBox(height: screenHeight*0.01),
                            Text(
                              '${cubit.userModel.email}',
                              style: TextStyle(
                                  fontSize: 13
                              ),
                            )
                          ])
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: defaultColor,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          color: defaultColor
                      ),
                    ),
                    onTap: (){
                      cubit.logOut();
                      navigateAndFinish(context, LoginScreen());

                    },
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.items,
              currentIndex: cubit.current_index,
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
              selectedItemColor: defaultColor,
            ),
            body: cubit.screens[cubit.current_index],
          );
        }
      ),
    );
  }
}