import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _db = DBHelper._internal();
  static Database? db;
  static DBHelper get instance => _db;
  DBHelper._internal();

  static Future<Database> get database async {
    return (db != null) ? db!:await initDatabase();
  }

  static Future<Database> initDatabase() async {
    return db = await openDatabase(
      join(await getDatabasesPath(),'idance_db.db'),
      onCreate: (database,version) async {

        // Dance Booking
        await db!.execute('CREATE TABLE DanceBooking (dance_booking_id	INTEGER,payment_id	INTEGER,student_id	INTEGER,dance_class_id	INTEGER,date_approved	INTEGER,FOREIGN KEY(payment_id) REFERENCES Payment(payment_id),FOREIGN KEY(dance_class_id) REFERENCES DanceClass(dance_id),FOREIGN KEY(student_id) REFERENCES Student(student_id),PRIMARY KEY(dance_booking_id))'
        );

        // Dance Class
        await db!.execute('CREATE TABLE DanceClass (dance_id	INTEGER instructor_id	INTEGER dance_name	TEXT dance_genre	TEXT dance_song	NUMERIC dance_difficulty	TEXT date	TEXT location	TEXT price	TEXT description	TEXT student_limit	INTEGER payment_details_id	INTEGER FOREIGN KEY(payment_details_id) REFERENCES PaymentDetails(payment_details_id) PRIMARY KEY(dance_id))'
        );

        // Instructor
        await db!.execute('CREATE TABLE Instructor ( instructor_id	INTEGER, user_id	INTEGER, rating	INTEGER, description	TEXT, dance_specialty	TEXT, FOREIGN KEY(user_id) REFERENCES User(user_id), PRIMARY KEY(instructor_id))'
        );

        // Like
        await db!.execute('CREATE TABLE Like (like_id	INTEGER,dance_class_id	INTEGER,student_id	INTEGER,date	TEXT,FOREIGN KEY(dance_class_id) REFERENCES DanceClass(dance_id),FOREIGN KEY(student_id) REFERENCES Student(student_id),PRIMARY KEY(like_id))'
        );

        // Payment
        await db!.execute('CREATE TABLE Payment (payment_id	INTEGER,amount	TEXT,date	TEXT,proof_of_payment	TEXT,PRIMARY KEY(payment_id))'
        );

        // Payment Details
        await db!.execute('CREATE TABLE PaymentDetails (payment_details_id	INTEGER,mode_of_payment	TEXT,account_name	TEXT,account_number	TEXT,PRIMARY KEY(payment_details_id))'
        );

        // Student
        await db!.execute('CREATE TABLE Student (student_id	INTEGER,user_id	INTEGER,level	TEXT,FOREIGN KEY(user_id) REFERENCES User(user_id),PRIMARY KEY(student_id))'
        );

        // User
        await db!.execute('CREATE TABLE User (user_id	INTEGER NOT NULL,first_name	TEXT NOT NULL,last_name	TEXT,gender	TEXT,contact_number	TEXT,email_address	TEXT,data_of_birth	TEXT,PRIMARY KEY(user_id))'
        );
      },
      version: 1
    );
  }
}