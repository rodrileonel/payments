import 'package:meta/meta.dart';

class StripeCustomResponse{
  final bool ok;
  final String message;

  StripeCustomResponse({
    @required this.ok, 
    this.message
  });
}