import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('C R U D  A P P'),
        ),
        body: Column(
          children: [
            Container(),
            OutlinedButton(
              onPressed: () {},
              child: Text('Create'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text('Read'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text('Update'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
