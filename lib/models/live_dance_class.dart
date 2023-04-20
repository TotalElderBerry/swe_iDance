import 'package:i_dance/models/dance_class.dart';

class LiveDanceClassModel extends DanceClassModel{
  int liveClassId;
  String date;
  String location;
  int studentLimit;
  // LiveDanceClassModel(this.liveClassId, {required this.date, required this.location, required this.studentLimit,required super.instructorId, required super.danceName, required super.danceSong, required super.danceDifficulty, required super.price, required super.description, required super.isAcceptingPayment}) : super(0, 0, instructorId: 0, danceName: '', danceSong: '', danceDifficulty: '', price: 0, description: '', isAcceptingPayment: false);

  LiveDanceClassModel(
    this.liveClassId, 
    {
      required this.date,
      required this.location,
      required this.studentLimit,
      required int instructorId,
      required String danceName,
      required String danceSong,
      required String danceDifficulty,
      required int price,
      required String description,
    }
  ):super(
    -1,
    -1,
    instructorId: instructorId,
    danceName: danceName,
    danceSong: danceSong,
    danceDifficulty: danceDifficulty,
    price: price,
    description: description,
    isAcceptingPayment: false
  );
}