part of 'payments_bloc.dart';

@immutable
abstract class PaymentsEvent {}

class OnActivateCard extends PaymentsEvent{
  final CreditDebitCard card;
  OnActivateCard(this.card);
}

class OnDesactivateCard extends PaymentsEvent{}
