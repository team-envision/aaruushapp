import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
List<dynamic> _eventList1=[];

class EventListPage extends StatefulWidget {
  const EventListPage({Key? key}) : super(key: key);

  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse('https://api.aaruush.org/api/v1/events'));
    if (response.statusCode == 200) {
      setState(() {
        _eventList1 = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load events');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event List'),
      ),
      body: _eventList1 == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _eventList1.length,
        itemBuilder: (BuildContext context, int index) {
          final event = _eventList1[index];
          return Column(
            children: [
              Text(event['name']),
              Text(event['structure']),
              Text(event['date']),
              Text(event['location']),
              Image.network(event['image'])
            ],

          );
        },
      ),
    );
  }
}
