import 'package:flutter/material.dart';

class InstructorSignIn extends StatefulWidget {
  const InstructorSignIn({Key? key}) : super(key: key);

  @override
  _InstructorSignInState createState() => _InstructorSignInState();
}

class _InstructorSignInState extends State<InstructorSignIn> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter description',
                border: OutlineInputBorder(),
              )
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Dance Specialty',
                hintText: 'Enter dance specialty',
                border: OutlineInputBorder(),
              )
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}


//rating
//description
//dance_specialty

