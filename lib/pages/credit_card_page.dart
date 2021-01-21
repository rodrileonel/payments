import 'package:flutter/material.dart';
import 'package:payments/widgets/pay_button.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class CreditCardPage extends StatelessWidget {

  static final routeName = 'CreditCard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        actions: [
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: (){}
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Hero(
              tag: '4242424242424242',
              child: CreditCardWidget(
                cardNumber: '4242424242424242',
                cvvCode: '213',
                expiryDate: '01/25',
                cardHolderName: 'Fernando Herrera',
                showBackView: false,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: PayButton()
          )
        ],
      ),
    );
  }
}