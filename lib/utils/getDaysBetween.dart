int getDaysBetweenFromToday (String date){
  List<String> token = date.split("-");
  DateTime to = DateTime(int.parse(token[0]),int.parse(token[1]),int.parse(token[2]));
  DateTime from = DateTime.now();
  return (to.difference(from).inHours / 24).round();
}