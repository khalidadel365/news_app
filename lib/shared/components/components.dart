import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../modules/web_view/web_view.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backgound = Colors.blue,
  bool isUpperCase = true,
  required String text,
  required VoidCallback onPressed,
  double radius = 15,
  bool isClickable = true,
}) => Container(
      width: width,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgound,
      ),
    );

Widget defaultFormField({required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onSubmit,
  ValueChanged? onChanged,
  FormFieldValidator? validate,
  required String? label,
  required IconData prefix,
  bool obsecureText = false,
  IconData? suffix,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
  TextStyle? inputColor,
  bool isClickable = true,
}) =>
    TextFormField(
      enabled: isClickable,
      onTap: onTap,
      controller: controller,
      //autovalidateMode: AutovalidateMode.always,
      keyboardType: type,
      obscureText: obsecureText,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      style: inputColor,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
      ),
    );



  Widget myDivider() => Container(
    width: double.infinity,
    color: Colors.grey[300],
    height: 1.7,
  );

  Widget buildArticleItem(article,context) => InkWell(
    onTap: (){
      navigateTo(context, WebViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
        vertical: 20,
      ),
      child: Row(
        children: [
          Container(
            width: 150.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image:  DecorationImage(
                image: NetworkImage(
                  "${article['urlToImage']}",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ) ,
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              height: 140.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis, // النقط اللي ظاهره
                      style: Theme.of(context).textTheme.bodyText1
                      ),
                    ),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );

  Widget articleBuilder(list,{isSearch=false}) => ConditionalBuilder(
    condition: list.length>0, // مش عامل Loading عشان بيتقل بين حالات كتير بس
    builder: (context) => ListView.separated(
      physics: const BouncingScrollPhysics(), // لما بscroll بتخفي اللون اللبني
      itemBuilder: (context,index) => buildArticleItem(list[index],context),
      separatorBuilder: (context,index) => myDivider(),
      itemCount: list.length,
    ),
    fallback: (context)=> isSearch? Container(): const Center(
        child: CircularProgressIndicator()
    ),
  );

  void navigateTo (context,widget) => Navigator.push(
      context,
    MaterialPageRoute(
        builder: (context) => widget
    )
  );

  Widget defaultTextButton({required String text,required VoidCallback function}) =>  TextButton(
      onPressed: function,
      child: Text(
          text.toUpperCase(),
      )
  );

