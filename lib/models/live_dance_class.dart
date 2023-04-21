import 'package:i_dance/models/dance_class.dart';
import 'package:i_dance/models/payment.dart';

import 'instructor.dart';

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
      required int danceClassId,
      required int price,
      required String danceName,
      required String danceSong,
      required String danceDifficulty,
      required String description,
      required Payment payment,
      required InstructorModel instructor,
    }
  ):super(
    danceClassId: danceClassId,
    payment: payment,
    danceName: danceName,
    danceSong: danceSong,
    danceDifficulty: danceDifficulty,
    price: price,
    description: description,
    instructor: instructor,
    isAcceptingPayment: false
  );


  factory LiveDanceClassModel.fromJson(Map<String, dynamic> json) {
    // instructorId = json['instructor_id'];
    // danceName = json['dance_name'];
    // danceSong = json['dance_song'];
    // danceDifficulty = json['dance_difficulty'];
    // date = json['date'];
    // location = json['location'];
    // price = json['price'];
    // description = json['description'];
    // studentLimit = json['student_limit'];
    // modeOfPayment = json['mode_of_payment'];
    // accountName = json['account_name'];
    // accountNumber = json['account_number'];
 
    Payment temp = Payment.fromJson(json['payment']);
    InstructorModel instructorTemp = InstructorModel.fromJson(json['instructor']);

    LiveDanceClassModel newLiveClass = LiveDanceClassModel(int.parse(json['live_danceclass_id']), date: json['date'], location: json['location'], studentLimit: int.parse(json['student_limit']), danceClassId: int.parse(json['dance_id']), danceName: json['dance_name'], danceSong: json['dance_song'], danceDifficulty: json['dance_difficulty'], price: int.parse(json['price']), description: json['description'], payment: temp, instructor: instructorTemp);

    return newLiveClass;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dance_name'] = this.danceName;
    data['dance_song'] = this.danceSong;
    data['dance_difficulty'] = this.danceDifficulty;
    data['date'] = this.date;
    data['location'] = this.location;
    data['price'] = this.price;
    data['description'] = this.description;
    data['student_limit'] = this.studentLimit;
    data['payment'] = this.payment.toJson();
    return data;
  }
}