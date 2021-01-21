import 'package:flutter/material.dart';
 

Route navigateFadeIn(BuildContext context, Widget page){
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: Duration(milliseconds:300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        child: child,
        opacity: Tween<double>(begin: 0,end: 1).animate(
          CurvedAnimation(curve: Curves.easeInOut,parent:animation)
        ),
      );
    },
  );
}