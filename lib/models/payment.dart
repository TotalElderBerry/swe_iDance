import 'package:flutter/widgets.dart';

class Payment{
  int paymentDetailsId;
  String modeOfPayment;
  String accountName;
  String accountNumber;

  Payment(
      this.paymentDetailsId,
      {
      required this.modeOfPayment,
      required this.accountName,
      required this.accountNumber});

  factory Payment.fromJson(Map<String, dynamic> json) {
    print(json['mode_of_payment']);
    return Payment(json['payment_details_id'], modeOfPayment: json['mode_of_payment'], accountName: json['account_name'], accountNumber: json['account_number']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_details_id'] = this.paymentDetailsId;
    data['mode_of_payment'] = this.modeOfPayment;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    return data;
  }
}