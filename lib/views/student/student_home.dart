
import 'package:flutter/material.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.edit),
                label: Text('Edit Profile'),
              ),
              Divider(),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.school),
                label: Text('Switch to Instructor'),
              ),
              Divider(),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.logout),
                label: Text('Logout'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                ),
                GestureDetector(
                  onTap:() {
                    _showBottomSheet(context);
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://www.w3schools.com/w3images/avatar2.png'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Explore',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.filter_list),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Do something when the button is pressed
                    },
                    child: Text(
                      'Newest',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Do something when the button is pressed
                    },
                    child: Text(
                      'Kpop',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Do something when the button is pressed
                    },
                    child: Text(
                      'Tiktok',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Do something when the button is pressed
                    },
                    child: Text(
                      'Hiphop',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://picsum.photos/250?image=9',
                        height: 150,
                        width: 200,
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Hello',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          'World',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.date_range),
                          SizedBox(width: 8),
                          Text('April 11, 2023'),

                          Icon(Icons.access_time),
                          SizedBox(width: 8),
                          Text('10:30 AM'),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    'https://picsum.photos/250?image=9',
                                    height: 150,
                                    width: 200,
                                  ),

                                  SizedBox(height: 8),
                                  Center(
                                    child: Text(
                                      'Hello',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      )
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Center(
                                   child: Text(
                                     'World',
                                    style: TextStyle(
                                      fontSize: 14,
                                             )   
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(Icons.date_range),
                                              SizedBox(width: 8),
                                              Text('April 11, 2023'),

                                              Icon(Icons.access_time),
                                              SizedBox(width: 8),
                                              Text('10:30 AM'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
               ],
             ),
           );
  }
}
                  