
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:payments/models/payment_intent_response.dart';
import 'package:payments/models/stripe_custom_response.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService{
  
  StripeService._();
  static final StripeService _instance = StripeService._();
  factory StripeService() => _instance;

  final _paymentURL = 'https://api.stripe.com/v1/payment_intents';
  final _secretKey  = 'sk_test_51ICseVKxa7c05uSwFk4DCfI8851hjqzYiLKpkyGC2pbA7Pwc4OuqW6wS3ODqLg4Azdfml13SpQsQHwNXYT3NcLTj00kq6kl7kZ';
  final _publicKey  = 'pk_test_51ICseVKxa7c05uSwy9ImUYf92EVADXlNRbdnTlW7B6jDIp6caF952DmIRjIMKYhf70lbyG0X3Ntg6KqkpFqb9nDH00YPJ6YGrv';

  void init(){
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: this._publicKey,
        androidPayMode: 'test',
        merchantId: 'test',
      ),
    );
  }

  Future payWithCard({
    @required String amount,
    @required String currency,
    @required CreditCard card,
  }) async{}

  Future<StripeCustomResponse> payWithNewCard({
    @required String amount,
    @required String currency,
  }) async{
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );

      final response = await this._doPayment(
        amount: amount, 
        currency: currency, 
        paymentMethod: paymentMethod
      );

      return response;
      
    } catch (e) {
      return StripeCustomResponse(
        ok: false,
        message: e.toString(),
      );
    }
  }

  Future payWithAppleAndGooglePay({
    @required String amount,
    @required String currency,
  }) async{}

  Future<PaymentIntentResponse> _createPaymentIntent({
    @required String amount,
    @required String currency,
  }) async{

    final dio = Dio();
    final data = {
      'amount': amount,
      'currency': currency,
    };

    final headerOptions = Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {
        'Authorization':'Bearer $_secretKey'
      }
    );

    try {

      final response = await dio.post(
        this._paymentURL,
        data: data,
        options: headerOptions,
      );

      return PaymentIntentResponse.fromJson(response.data);

    } catch (e) {
      return PaymentIntentResponse(
        status: '400'
      );
    }

  }

  Future<StripeCustomResponse> _doPayment({
    @required String amount,
    @required String currency,
    @required PaymentMethod paymentMethod,
  }) async{

    try {
      //intento de pago
      final paymentIntentResponse = await this._createPaymentIntent(
        amount: amount, 
        currency: currency
      );

      //hacer cobro
      final paymentResultResponse = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntentResponse.clientSecret,
          paymentMethodId: paymentMethod.id
        ),
      );

      if(paymentResultResponse.status == 'succeeded')
        return StripeCustomResponse(ok: true);
      else
        return StripeCustomResponse(ok: false,message: 'Fallo ${paymentResultResponse.status}');
    
    } catch (e) {
      return StripeCustomResponse(
        ok: false,
        message: e.toString(),
      );
    }

  }

}