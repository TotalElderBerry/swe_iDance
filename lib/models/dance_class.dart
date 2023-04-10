import 'dart:html';

class DanceClassModel{
  String dance_class_id;
  String danceClassName;
  List<String> danceGenre;
  String danceSong;
  DateTime date;
  String address;
  Location addressCoordinates;
  int price;
  String instructor;
  List<String> students;

  DanceClassModel(this.dance_class_id,this.danceClassName,this.danceGenre,this.danceSong,this.date,this.address,this.addressCoordinates,this.price,this.instructor,this.students);
}