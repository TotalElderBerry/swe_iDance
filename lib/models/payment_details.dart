import 'package:flutter/widgets.dart';

class PaymentDetails{
  int paymentDetailsId;
  String modeOfPayment;
  String accountName;
  String accountNumber;

  PaymentDetails(
      this.paymentDetailsId,
      {
      required this.modeOfPayment,
      required this.accountName,
      required this.accountNumber});

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(int.parse(json['payment_details_id']), modeOfPayment: json['mode_of_payment'], accountName: json['account_name'], accountNumber: json['account_number']);
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    //data['payment_details_id'] = this.paymentDetailsId;
    data['mode_of_payment'] = this.modeOfPayment;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    return data;
  }
}