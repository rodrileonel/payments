import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payments/bloc/payment/payments_bloc.dart';
import 'package:payments/widgets/pay_button.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class CreditCardPage extends StatelessWidget {
  static final routeName = 'CreditCard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            BlocProvider.of<PaymentsBloc>(context).add(OnDesactivateCard());
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: BlocBuilder<PaymentsBloc, PaymentsState>(
              builder: (context, state) {
                return Hero(
                  tag: state.card.cardNumber,
                  child: CreditCardWidget(
                    cardNumber: state.card.cardNumber,
                    cvvCode: state.card.cvv,
                    expiryDate: state.card.expiracyDate,
                    cardHolderName: state.card.cardHolderName,
                    showBackView: false,
                  ),
                );
              },
            ),
          ),
          Positioned(bottom: 0, child: PayButton())
        ],
      ),
    );
  }
}
