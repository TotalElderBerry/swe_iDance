import 'dart:html';

class DanceClassModel{
  int danceClassId;
  int instructorId;
  String danceName;
  String danceSong;
  String danceDifficulty;
  int price;
  String description;
  int paymentDetailsId;
  bool isAcceptingPayment;

  DanceClassModel(this.danceClassId, this.paymentDetailsId, {required this.instructorId, required this.danceName, required this.danceSong, required this.danceDifficulty, required this.price, required this.description,  required this.isAcceptingPayment});

}