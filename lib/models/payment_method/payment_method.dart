import 'package:e_commerce/utils/extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_method.g.dart';

@JsonSerializable()
class PaymentMethod extends Equatable {
  @JsonKey(name: 'payment_method_id')
  final String paymentMethodId;

  @JsonKey(name: 'card_number')
  final String cardNumber;

  @JsonKey(name: 'cardholder_name')
  final String cardholderName;

  @JsonKey(name: 'expiry_date')
  final String expiryDate;

  @JsonKey(name: 'cvv')
  final String cvv;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const PaymentMethod({
    required this.paymentMethodId,
    required this.cardNumber,
    required this.cardholderName,
    required this.expiryDate,
    required this.cvv,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);

  @override
  List<Object?> get props => [paymentMethodId];
}

final List<PaymentMethod> dummyListPaymentMethod = [
  PaymentMethod(
    paymentMethodId: ''.generateUID(),
    cardNumber: '4024007164591702',
    cardholderName: 'John Doe',
    expiryDate: '08/25',
    cvv: '666',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  PaymentMethod(
    paymentMethodId: ''.generateUID(),
    cardNumber: '2329150755960492',
    cardholderName: 'Johnny Sins',
    expiryDate: '06/24',
    cvv: '696',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
