import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:payments/bloc/payment/payments_bloc.dart';
import 'package:payments/data/credit_debit_cards.dart';
import 'package:payments/helpers/alerts.dart';
import 'package:payments/helpers/navigate_fade_in.dart';
import 'package:payments/pages/credit_card_page.dart';
import 'package:payments/services/stripe_service.dart';
import 'package:payments/widgets/pay_button.dart';


class HomePage extends StatelessWidget {

  static final routeName = 'Home';
  final stripeService = StripeService();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final payBloc = BlocProvider.of<PaymentsBloc>(context).state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        actions: [
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () async{

              showLoading(context);

              final response = await stripeService.payWithNewCard(
                amount: payBloc.amoutString,
                currency: payBloc.currency,
              );

              Navigator.pop(context);

              if(response.ok)
                showAlert(context, 'Tarjeta ok', 'Todo ok');
              else
                showAlert(context, 'Algo salio mal', response.message);
            }
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            width: size.width,
            height: size.height,
            top: size.height/5,
            child: PageView.builder(
              controller: PageController(
                viewportFraction: 0.85
              ),
              physics: BouncingScrollPhysics(),
              itemCount: cards.length,
              itemBuilder:(_,i){
                return InkWell(
                  onTap: (){
                    BlocProvider.of<PaymentsBloc>(context).add(OnActivateCard(cards[i]));
                    Navigator.push(context, navigateFadeIn(context,CreditCardPage()));
                  },
                  child: Hero(
                    tag: cards[i].cardNumber,
                    child: CreditCardWidget(
                      cardNumber: cards[i].cardNumberHidden, 
                      expiryDate: cards[i].expiracyDate, 
                      cardHolderName: cards[i].cardHolderName, 
                      cvvCode: cards[i].cvv, 
                      showBackView: false,
                    ),
                  ),
                );
              }
            ),
          ),
          Positioned(
            bottom: 0,
            child: PayButton()
          )
        ],
      )
    );
  }
}