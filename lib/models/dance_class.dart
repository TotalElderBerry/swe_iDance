import 'package:i_dance/models/payment.dart';

import 'instructor.dart';

class DanceClassModel{
  int danceClassId;
  InstructorModel instructor;
  String danceName;
  String danceSong;
  String danceDifficulty;
  int price;
  String description;
  Payment payment;
  bool isAcceptingPayment;

  DanceClassModel({required this.danceClassId, required this.payment, required this.danceName, required this.danceSong, required this.danceDifficulty, required this.price, required this.description,  required this.isAcceptingPayment, required this.instructor});

}