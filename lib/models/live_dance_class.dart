import 'package:i_dance/models/dance_class.dart';
import 'package:i_dance/models/payment_details.dart';

import 'instructor.dart';

class LiveDanceClassModel extends DanceClassModel{
  String? img;
  int liveClassId;
  String date;
  String location;
  int studentLimit;
  int? numOfPending;
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
      required PaymentDetails payment,
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
 
    PaymentDetails temp = PaymentDetails.fromJson(json['payment']);
    InstructorModel instructorTemp = InstructorModel.fromJson(json['instructor']);
    
    LiveDanceClassModel newLiveClass = LiveDanceClassModel(int.parse(json['live_danceclass_id']), date: json['date'], location: json['location'], studentLimit: int.parse(json['student_limit']), danceClassId: int.parse(json['dance_id']), danceName: json['dance_name'], danceSong: json['dance_song'], danceDifficulty: json['dance_difficulty'], price: int.parse(json['price']), description: json['description'], payment: temp, instructor: instructorTemp);

    return newLiveClass;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['instructor_id'] = '${instructor.instructorId}';
    data['dance_name'] = danceName;
    data['dance_song'] = danceSong;
    data['dance_difficulty'] = danceDifficulty;
    data['date'] = date;
    data['location'] = location;
    data['price'] = '${price}';
    data['description'] = description;
    data['student_limit'] = studentLimit;
    data['mode_of_payment'] = payment.modeOfPayment;
    data['account_name'] = payment.accountName;
    data['account_number'] = payment.accountNumber;
    return data;
  }
}

//  "instructor_id": 24,
//     "dance_name": "Cupid Tiktok",
//     "dance_song": "Cupid",
//     "dance_difficulty": "Hard",
//     "date": "06/14/2001",
//     "location": "Talamban",
//     "price": "400",
//     "description": "Forda Tiktok",
//     "student_limit": 20,
//     "mode_of_payment": "Paypal",
//     "account_name": "Brian",
//     "account_number": "12345"