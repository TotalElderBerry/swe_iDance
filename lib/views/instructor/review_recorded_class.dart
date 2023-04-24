import 'package:flutter/material.dart';
import 'package:i_dance/models/recorded_dance_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewRecordedClass extends StatelessWidget {
  const ReviewRecordedClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () => null,
          child: const Center(
            child: Text('Create Dance'),
          ),
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              recordedDance.last['classname'],
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.music_note,
                      color: Colors.purple,
                    ),
                    Text(recordedDance.last['song']),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.directions_walk,
                      color: Colors.purple,
                    ),
                    Text(recordedDance.last['difficulty']),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.money,
                      color: Colors.purple,
                    ),
                    Text(recordedDance.last['price']),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.link,
                      color: Colors.purple,
                    ),
                    TextButton(
                      onPressed: () => launchUrl(
                        Uri.parse('https://' + recordedDance.last['link']),
                        mode: LaunchMode.externalApplication,
                      ),
                      child: Text(recordedDance.last['link']),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const Divider(),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Payment Details',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 12,
            ),
            const ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://mb.com.ph/wp-content/uploads/2021/09/32049-1568x1460.png'),
              ),
              title: Text("PayMaya"),
            ),
            const SizedBox(
              height: 24,
            ),
            const Divider(),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Dance Description',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(recordedDance.last['details']),
          ],
        ),
      ),
    );
  }
}
