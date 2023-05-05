import 'package:flutter/material.dart';

class HomeDanceCard extends StatelessWidget {
  const HomeDanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: 210,
          child: Column(
            children: [
              Container(
                height: 150,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  'https://images.unsplash.com/photo-1483884105135-c06ea81a7a80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y292ZXIlMjBnaXJsfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://i.pinimg.com/originals/ae/24/87/ae24874dd301843548c034a3d2973658.png',
                        ),
                        radius: 15,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Enter Name',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'I need a Big Boy Dance',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range_rounded,
                        color: Colors.orange,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        'May 05, 2023',
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_filled_outlined,
                        color: Colors.orange,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        '6:00',
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: Colors.orange,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    'UCC Campus',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
