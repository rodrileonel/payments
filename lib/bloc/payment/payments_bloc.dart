import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payments/models/credit_debit_card.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  PaymentsBloc() : super(PaymentsState());

  @override
  Stream<PaymentsState> mapEventToState( PaymentsEvent event ) async* {
    if (event is OnActivateCard)
      yield state.copyWith(activeCard: true, card: event.card);
    if (event is OnDesactivateCard)
      yield state.copyWith(activeCard: false);
  }
}
