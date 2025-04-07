import 'dart:ui';

import 'package:flutter/material.dart';

const defaultColor = Color(0xFF0288D1);
//https://newsapi.org/v2/everything?q=tesla&apiKey=0c53f0968a1a46f09dd4
// dd8dfec494cc
String? uId;
bool? isOpened = false; // عشان لما يفتح علي login ميعملش get مرتين

bool lightMode = true;
bool isAppBarVisible = true;
bool showBottomNav = true;
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
