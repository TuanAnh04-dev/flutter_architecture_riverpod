import 'package:flutter/material.dart';

class BoardPage extends StatelessWidget {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var wscreen = MediaQuery.of(context).size.width;
    var hscreen = MediaQuery.of(context).size.height;

    final _searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Trolle'), backgroundColor: Colors.grey.shade300),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
        width: wscreen,
        height: hscreen,
        color: Colors.white70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('Các dự án của bạn', style: TextStyle(fontSize: 20)),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('Các dự án khách', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
