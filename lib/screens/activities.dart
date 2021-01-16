import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

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
    initializeDateFormatting();
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
          locale: 'pt_BR',
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
          calendarStyle: CalendarStyle(
            weekendStyle: Theme.of(context).accentTextTheme.bodyText1,
            weekdayStyle: Theme.of(context).accentTextTheme.bodyText1,
            holidayStyle: TextStyle(color: Theme.of(context).accentTextTheme.bodyText1.color.withOpacity(0.5)),
            selectedColor: Theme.of(context).accentColor,
            markersColor: Theme.of(context).primaryColor,
            outsideWeekendStyle: TextStyle(color: Theme.of(context).accentTextTheme.bodyText1.color.withOpacity(0.5)),
            outsideHolidayStyle: TextStyle(color: Theme.of(context).accentTextTheme.bodyText1.color.withOpacity(0.5)),
            todayColor: Theme.of(context).primaryColor.withOpacity(0.25),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Theme.of(context).accentTextTheme.bodyText1.color.withOpacity(0.75)),
            weekendStyle: TextStyle(color: Theme.of(context).accentTextTheme.bodyText1.color.withOpacity(0.75))
          ),
          headerStyle: HeaderStyle(
            centerHeaderTitle: true
          ),
          builders: CalendarBuilders(
            markersBuilder: (context, date, events, holidays) =>
              [Container(width: 12.0, height: 12.0, decoration: BoxDecoration(shape: BoxShape.circle, color:  Theme.of(context).primaryColor),)]
          ),
        ),
        ..._eventsSelectedDay.map((event) => _buildCardFromEvent(event)).toList()
      ],)
    );
  }

  _updateEvents() async {
    Map<DateTime, List<dynamic>> events = {};
    List<Map<String, dynamic>> rawData = [{
      'date': DateTime(2021, 1, 10),
      'events': [
        { 
          'restrictToLigantes': true,
          'restrictToExtensionistas': true,
          'pratica': false,
          'title': 'atividade 1',
          'description': 'descricacao'
        },
        { 
          'restrictToLigantes': true,
          'restrictToExtensionistas': true,
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

  _buildCardFromEvent(event) {
    return Card(child: Container(
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
    ));
  }

}