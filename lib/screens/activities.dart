import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ActivitiesScreen extends StatefulWidget {
  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;
 List<dynamic> _eventsSelectedDay = [];


  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _updateEvents();
  }
  
  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Calendário de Atividades'),
      ),
      body: ListView(children: [
        TableCalendar(
          calendarController: _calendarController,
          events: _events,
          onDaySelected: (day, events, holidays) {
            setState(() {
              _eventsSelectedDay = events;
            });
          },
          availableCalendarFormats: {
            CalendarFormat.month: 'Mês'
          },
        ),
        ..._eventsSelectedDay.map((event) => Card(child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(children: [
                Text(event['title']),
                Spacer(),
                Text(event['pratica'] ? 'Prática' : ''),
              ],),
              SizedBox(height: 12),
              Row(children: [
                Text(event['description'])
              ],)
            ]
          )
        ),)).toList()

      ],)
    );
  }

  _updateEvents() async {
    Map<DateTime, List<dynamic>> events = {};
    List<Map<String, dynamic>> rawData = [{
      'date': DateTime(2021, 1, 10),
      'events': [
        { 
          'restrictToLigante': true,
          'restrictToExtensionista': true,
          'pratica': false,
          'title': 'atividade 1',
          'description': 'descricacao'
        },
        { 
          'restrictToLigante': true,
          'restrictToExtensionista': true,
          'pratica': true,
          'title': 'atividade 2',
          'description': 'descricacao'
        }
      ]
    }];
    rawData.forEach((event) => {
      events[event['date']] = event['events'],
    });
    setState(() {
      this._events = events;
    });
  }
}