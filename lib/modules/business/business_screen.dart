import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/news_app/cubit/cubit.dart';
import '../../layout/news_app/cubit/states.dart';
import '../../shared/components/components.dart';

class BusinessScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        List<dynamic> list =NewsCubit.get(context).business;
         return ConditionalBuilder(
           condition: list.length>0, // مش عامل Loading عشان بيتقل بين حالات ك
           builder: (context) => ListView.separated(
             physics: BouncingScrollPhysics(), // لما بscroll بتخفي اللون اللبني
             itemBuilder: (context,index) => buildArticleItem(list[index],context),
             separatorBuilder: (context,index) => myDivider(),
             itemCount: list.length,
           ),
           fallback: (context)=>const Center(
               child: CircularProgressIndicator()
           ),
         );
      },
    );
  }


}