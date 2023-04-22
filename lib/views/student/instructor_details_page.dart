import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../models/instructor.dart';
import '../../widgets/student/dance_class_card.dart';

class InstructorDetailsPage extends StatelessWidget {
  InstructorModel instructor;
  InstructorDetailsPage({super.key, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 32.0, left: 32, ),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ 
                  Container(
                    height: 200,
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                              child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr73f8IH4ehZ5zKLQiX8-Svlaj3IEt8dU5LA&usqp=CAU',
                              fit: BoxFit.contain,
                              height: 150,
                              ),
                          ),
                          const Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: CircleAvatar(
                                        radius:50,
                                        backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/businessman-profile-icon-male-portrait-flat-design-vector-illustration-47075259.jpg'),
                                      ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text('${instructor.firstName} ${instructor.lastName}', style: Theme.of(context).textTheme.titleLarge,),
                  RatingBar.builder(
                    itemSize: 20.0,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
              
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Bio", style: Theme.of(context).textTheme.headlineSmall,textAlign: TextAlign.left,),
                    ],
                  ),
                  const SizedBox(height: 10,),
              
                  Text("Hey there, I'm Sarah Hero Nimo – dance instructor, choreographer, and all-around dance enthusiast. I'm on a mission to help you move, groove, and find your rhythm. So, what are you waiting for? Let's dance!", style: Theme.of(context).textTheme.titleSmall,)
                ],
              ),
              const SizedBox(height: 10,),
              DefaultTabController(length: 2, child: Container(
                child: TabBar(
                  tabs: [
                  Tab(
                    icon: Text("Live", style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  Tab(
                    icon: Text("Recording", style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ])
              )),
              SizedBox(height: 20,),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // DanceClassCard(),
                        // DanceClassCard(),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}