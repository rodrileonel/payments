import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class FinishPagePage extends StatelessWidget {

  static final routeName = 'FinishPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Icon(FontAwesomeIcons.star, color: Colors.white, size: 90,),
            SizedBox(height:20),
            Text('Pago exitoso !',style:TextStyle(fontSize: 20))
          ]
        ),
      )
    );
  }
}