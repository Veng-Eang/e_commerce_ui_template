import 'package:e_commerce/utils/extension.dart';
import 'package:json_annotation/json_annotation.dart';

import '../address/address.dart';
import '../payment_method/payment_method.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  @JsonKey(name: 'account_id')
  String accountId;

  @JsonKey(name: 'full_name')
  String fullName;

  @JsonKey(name: 'email_address')
  String emailAddress;

  @JsonKey(name: 'phone_number')
  String phoneNumber;

  @JsonKey(name: 'role')
  int role;

  @JsonKey(name: 'ban_status')
  bool banStatus;

  @JsonKey(name: 'primary_payment_method')
  PaymentMethod? primaryPaymentMethod;

  @JsonKey(name: 'primary_address')
  Address? primaryAddress;

  @JsonKey(name: 'photo_profile_url')
  String photoProfileUrl;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  Account({
    required this.accountId,
    required this.fullName,
    required this.emailAddress,
    required this.phoneNumber,
    required this.role,
    required this.banStatus,
    required this.createdAt,
    required this.updatedAt,
    this.primaryPaymentMethod,
    this.primaryAddress,
    required this.photoProfileUrl,
  });

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

final List<Account> dummyListAccount = [
  Account(
    accountId: ''.generateUID(),
    fullName: 'John Doe',
    emailAddress: 'Washington DC',
    phoneNumber: '1555123456',
    role: 1,
    banStatus: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    photoProfileUrl: 'https://i.pravatar.cc/300',
  ),
  Account(
    accountId: ''.generateUID(),
    fullName: 'Krystal Richardson',
    emailAddress: 'Washington DC',
    phoneNumber: '1555123456',
    role: 1,
    banStatus: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    photoProfileUrl: 'https://i.pravatar.cc/300',
  ),
  Account(
    accountId: ''.generateUID(),
    fullName: 'Paula Ponce',
    emailAddress: 'Washington DC',
    phoneNumber: '1555123456',
    role: 1,
    banStatus: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    photoProfileUrl: 'https://i.pravatar.cc/300',
  ),
  Account(
    accountId: ''.generateUID(),
    fullName: 'Russell Cantu',
    emailAddress: 'Washington DC',
    phoneNumber: '1555123456',
    role: 1,
    banStatus: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    photoProfileUrl: 'https://i.pravatar.cc/300',
  ),
  Account(
    accountId: ''.generateUID(),
    fullName: 'Jordon Mullins',
    emailAddress: 'Washington DC',
    phoneNumber: '1555123456',
    role: 1,
    banStatus: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    photoProfileUrl: 'https://i.pravatar.cc/300',
  ),
];

final Account dummyAccount = Account(
  accountId: ''.generateUID(),
  fullName: 'John Doe',
  emailAddress: 'Washington DC',
  phoneNumber: '1555123456',
  role: 1,
  banStatus: false,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  photoProfileUrl: 'https://i.pravatar.cc/300',
);
