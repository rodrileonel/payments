import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payments/bloc/payment/payments_bloc.dart';
import 'package:payments/helpers/alerts.dart';
import 'package:payments/services/stripe_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final payBloc = BlocProvider.of<PaymentsBloc>(context).state;

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
              Text('${payBloc.amount}} ${payBloc.currency}',style: TextStyle(fontSize: 20)),
            ],
          ),
          BlocBuilder<PaymentsBloc, PaymentsState>(
            builder: (context, state) {
              return _ButtonPay(state);
            },
          )
        ]
      ),
    );
  }
}

class _ButtonPay extends StatelessWidget {

  final PaymentsState state;

  const _ButtonPay(this.state);

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
              state.activeCard 
                ? Icon(FontAwesomeIcons.solidCreditCard)
                : Platform.isAndroid 
                  ? Icon(FontAwesomeIcons.google)
                  : Icon(FontAwesomeIcons.apple),
              
            Text('  Pay',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
          ],
            
      ),
      onPressed: () async => state.activeCard 
        ? payWithCard(context)
        : payWithGoogleApple(context),

    );
    //return true  ? buildStoresPay(context) : buildCardPay(context);
  }

  payWithCard(BuildContext context) async {
    showLoading(context);

    final stripeService =StripeService();
    final payBloc = BlocProvider.of<PaymentsBloc>(context).state;

    final response = await stripeService.payWithCard(
      amount: payBloc.amoutString, 
      currency: payBloc.currency, 
      card: CreditCard(
        number:payBloc.card.cardNumber,
        expMonth:int.parse(payBloc.card.expiracyDate.split('/')[0]),
        expYear: int.parse(payBloc.card.expiracyDate.split('/')[1]),
      )
    );

    Navigator.pop(context);

    if(response.ok)
      showAlert(context, 'Tarjeta ok', 'Todo ok');
    else
      showAlert(context, 'Algo salio mal', response.message);

  }

  payWithGoogleApple(BuildContext context) async {

    final stripeService =StripeService();
    final payBloc = BlocProvider.of<PaymentsBloc>(context).state;

    final response = await stripeService.payWithAppleAndGooglePay(
      amount: payBloc.amoutString, 
      currency: payBloc.currency,
    );
/*
    Navigator.pop(context);

    if(response.ok)
      showAlert(context, 'Tarjeta ok', 'Todo ok');
    else
      showAlert(context, 'Algo salio mal', response.message);
*/
  }
 
}