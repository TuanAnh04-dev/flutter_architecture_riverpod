import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/module/user/logic/user_provider.dart';

class ListUser extends ConsumerWidget {
  const ListUser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Users', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: userList.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (user) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: user.length,
            itemBuilder: (context, index) {
              final userItem = user[index];
              return Container(
                width: 100,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                height: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(62, 158, 158, 158),
                      spreadRadius: 4,
                      blurRadius: 6,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${userItem.firstName} ${userItem.lastName}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          userItem.gender == 'female'
                              ? Icon(
                                  Icons.female,
                                  color: Colors.pinkAccent,
                                  size: 28,
                                )
                              : Icon(
                                  Icons.male,
                                  color: Colors.blueAccent,
                                  size: 28,
                                ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email: ${userItem.email}'),
                          Text('Phone: ${userItem.phone}'),
                          Text('Username: ${userItem.username}'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
