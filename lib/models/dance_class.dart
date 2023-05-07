import 'package:i_dance/models/payment_details.dart';

import 'instructor.dart';

class DanceClassModel{
  int danceClassId;
  InstructorModel instructor;
  String danceName;
  String danceSong;
  String danceDifficulty;
  int price;
  String description;
  PaymentDetails payment;
  bool isAcceptingPayment;
  int isLiked = 0;
  int likes = 0;

  DanceClassModel({required this.danceClassId, required this.payment, required this.danceName, required this.danceSong, required this.danceDifficulty, required this.price, required this.description,  required this.isAcceptingPayment, required this.instructor});

}