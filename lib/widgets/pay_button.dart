import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.only(
          topLeft:Radius.circular(60),
          topRight:Radius.circular(60),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Text('250.99 USD',style: TextStyle(fontSize: 20)),
            ],
          ),
          _ButtonPay()
        ]
      ),
    );
  }
}

class _ButtonPay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          true
            ? Platform.isAndroid 
              ? Icon(FontAwesomeIcons.google)
              : Icon(FontAwesomeIcons.apple)
            : Icon(FontAwesomeIcons.solidCreditCard),
          Text('  Pay',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
        ],
      ),
      onPressed: () {  },
    );
    //return true  ? buildStoresPay(context) : buildCardPay(context);
  }

  Widget buildStoresPay(BuildContext context) {
    return MaterialButton(
      height: 50,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Platform.isAndroid 
            ? Icon(FontAwesomeIcons.google)
            : Icon(FontAwesomeIcons.apple),
          Text('  Pay',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
        ],
      ),
      onPressed: () {  },
    );
  }

  Widget buildCardPay(BuildContext context) {
    return MaterialButton(
      height: 50,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Icon(FontAwesomeIcons.solidCreditCard),
          Text('  Pay',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
        ],
      ),
      onPressed: () {  },
    );
  }
}