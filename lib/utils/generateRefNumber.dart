import 'dart:math';

String generateReferenceNumber(int lengthOfString){
  final random = Random();
    const allChars='AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
   // below statement will generate a random string of length using the characters 
   // and length provided to it
    final randomString = List.generate(lengthOfString, 
                          (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString;    // return the generated string
}