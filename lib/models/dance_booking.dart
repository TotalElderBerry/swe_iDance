import 'package:i_dance/models/recorded_dance_model.dart';

import 'live_dance_class.dart';

class DanceBooking {
	LiveDanceClassModel? liveDanceClass;
  RecordedDanceClassModel? recordedDanceClass;
	int? danceBookingId;
	int? paymentId;
	int? studentId;
	int? danceClassId;
	String? dateApproved;
	Payment? payment;

	DanceBooking({this.liveDanceClass, this.danceBookingId, this.paymentId, this.studentId, this.danceClassId, this.dateApproved, this.payment});

	DanceBooking.fromJson(Map<String, dynamic> json) {
		liveDanceClass = json['live_dance_class'] != null ? new LiveDanceClassModel.fromJson(json['live_dance_class']) : null;
		danceBookingId = json['dance_booking_id'];
		paymentId = json['payment_id'];
		studentId = json['student_id'];
		danceClassId = json['dance_class_id'];
		dateApproved = json['date_approved'];
		payment = json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.liveDanceClass != null) {
      data['live_dance_class'] = this.liveDanceClass!.toJson();
    }
		data['dance_booking_id'] = this.danceBookingId;
		data['payment_id'] = this.paymentId;
		data['student_id'] = this.studentId;
		data['dance_class_id'] = this.danceClassId;
		data['date_approved'] = this.dateApproved;
		if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
		return data;
	}
}

class Payment {
	int? paymentId;
	int? amount;
	String? date;
	String? senderName;
	String? referenceNumber;

	Payment({this.paymentId, this.amount, this.date, this.senderName, this.referenceNumber});

	Payment.fromJson(Map<String, dynamic> json) {
		paymentId = json['payment_id'];
		amount = json['amount'];
		date = json['date'];
		senderName = json['sender_name'];
		referenceNumber = json['reference_number'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['payment_id'] = this.paymentId;
		data['amount'] = this.amount;
		data['date'] = this.date;
		data['sender_name'] = this.senderName;
		data['reference_number'] = this.referenceNumber;
		return data;
	}
}
