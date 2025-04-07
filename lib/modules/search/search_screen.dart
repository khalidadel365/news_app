import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/cubit/cubit.dart';
import 'package:news_app/modules/search/cubit/states.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          var list = SearchCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
                SearchCubit.get(context).search.clear();
              }, icon: Icon(Icons.arrow_back)),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      label: 'Search',
                      onChanged: (value){
                        SearchCubit.get(context).getSearch(value);
                      },
                      prefix: Icons.search),
                ),
                Expanded(
                    child: articleBuilder(list, context,isSearch: true)
                )
              ],
            ),
          );
        },
      )
    );
  }
}
