import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/news_app/cubit/cubit.dart';
import '../../layout/news_app/cubit/states.dart';
import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){} ,
      builder:(context,state){
        var list = NewsCubit.get(context).search;
        return  Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 18
                ),
                child: defaultFormField(
                  inputColor: Theme.of(context).textTheme.bodyText2,
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  controller: searchController,
                  type: TextInputType.text,
                  validate: (value){
                    if(value.isEmpty){
                      return'search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search_rounded,
                ),
              ),
              Expanded(
                  child: articleBuilder(
                      list,isSearch: true)
              ),
            ],
          ),
        );
      } ,
    );
  }
}
