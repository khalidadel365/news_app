import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/shared/components/constants.dart';

import '../../modules/web_view/web_view_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  double height = 50,
  Color background = defaultColor,
  bool isUpperCase = true,
  required String text,
  required VoidCallback onPressed,
  bool isClickable = true,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: defaultColor
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
              fontSize: 13.6,
              color: Colors.white,
              fontWeight: FontWeight.w700
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onSubmit,
  ValueChanged? onChanged,
  FormFieldValidator? validate,
  String? label,
  IconData? prefix,
  bool obsecureText = false,
  IconData? suffix,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
  String? hintText,
  TextStyle inputStyle = const TextStyle(
    fontSize: 16.5,
    fontWeight: FontWeight.normal,
  ),
  bool isClickable = true,
  FocusNode? focusNode,
}) =>
    TextFormField(
      focusNode: focusNode,
      enabled: isClickable,
      onTap: onTap,
      controller: controller,
      //autovalidateMode: AutovalidateMode.always,
      keyboardType: type,
      obscureText: obsecureText,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      style: inputStyle,
      cursorColor: defaultColor,
      cursorHeight: 20,
      cursorWidth: 2,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.grey.shade100,
        filled: true,
        labelText: label,
        labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17

        ),
        errorStyle: TextStyle(fontSize: 12.5, color: Colors.red),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: Icon(
          prefix,
          size: 25,
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

Widget defaultTextButton(
    {required VoidCallback function, required String text}) =>
    TextButton(
        onPressed: function,
        child: Text(
          '${text.toUpperCase()}',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: defaultColor),
        ));

void navigateTo(
    {
      context,
      required nextScreen,
      bool? fullScreen,
      bool isShownAppBar = true,
      bool isShownBottomNavBar = true,
    }) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ));
}

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) {
  return false;
});

void showToast({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates {
  SUCCESS,
  ERROR,
  WARNING,
}

Color chooseToastColor(ToastStates state) {
  Color color = Colors.green;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

PreferredSizeWidget defaultAppBar({
  @required BuildContext? context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      titleSpacing: 5,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context!);
          },
          icon: Icon(
            Icons.add
          )),
      title: Text(
        '$title',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      actions: actions,
    );

Widget buildArticleItem (article,context){
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  return InkWell(

    onTap: (){
      navigateTo(context: context, nextScreen: WebViewScreen(article['url']));
    },
    child:   Padding(
      padding: const EdgeInsets.all(20.0),
      child: LayoutBuilder(
        builder: (context,constraints){
          double imageSize = constraints.maxWidth > 600 ? 150 : 120;
          return  Row(
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('${article['urlToImage']}')
                    )
                ),
              ),
              SizedBox(
                width: screenWidth*0.05,
              ),
              Expanded(
                child: Container(
                  height: screenHeight*0.15,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${article['title']}',
                          maxLines: 3 ,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Text(
                        '${article['publishedAt']}]',style: TextStyle(
                        color: Colors.grey,
                        fontSize: constraints.maxWidth > 600 ? 16 : 14,
                      ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    ),
  );
}

Widget articleBuilder(List<dynamic> list,context,{isSearch = false}) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index) => buildArticleItem(list[index],context),
      separatorBuilder: (BuildContext context, int index) => myDivider(),
      itemCount: list.length,
    ),
    fallback: (context) => isSearch? Container(): Center(child: CircularProgressIndicator(color: defaultColor,))

);

