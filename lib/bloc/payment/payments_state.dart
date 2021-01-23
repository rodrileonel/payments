part of 'payments_bloc.dart';

@immutable
class PaymentsState{
  final double amount;
  final String currency;
  final bool activeCard;
  final CreditDebitCard card;

  PaymentsState({
    this.amount = 375.99,
    this.currency = 'USD',
    this.activeCard = false,
    this.card
  });

  PaymentsState copyWith({
    String currency,
    double amount,
    bool activeCard,
    CreditDebitCard card,
  }) => PaymentsState(
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    activeCard: activeCard ?? this.activeCard,
    card: card ?? this.card,
  );
}

