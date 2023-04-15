import 'package:flutter/widgets.dart';

class Payment{
  String payment_id;
  double amount;
  DateTime date;
  String proofOfPayment; // to be changed into Image File

  Payment(this.payment_id,this.amount,this.date,this.proofOfPayment);
}