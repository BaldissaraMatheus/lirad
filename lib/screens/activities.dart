import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/lirad_user.dart';
import 'package:provider/provider.dart';
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
  LiradUser user;


  @override
  void initState() {
    super.initState();
    this.user = Provider.of<LiradUser>(context, listen: false);
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
          rowHeight: 45,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Theme.of(context).accentTextTheme.bodyText1.color.withOpacity(0.75)),
            weekendStyle: TextStyle(color: Theme.of(context).accentTextTheme.bodyText1.color.withOpacity(0.75))
          ),
          headerStyle: HeaderStyle(
            centerHeaderTitle: true
          ),
          builders: CalendarBuilders(
            markersBuilder: (context, date, events, holidays) =>
              [Container(width: 12.0, height: 12.0, decoration: BoxDecoration(shape: BoxShape.circle, color:  Theme.of(context).primaryColor.withOpacity(0.9)),)]
          ),
        ),
        ..._eventsSelectedDay.map((event) => _buildCardFromEvent(event)).toList()
      ],)
    );
  }

  _updateEvents() async {
    Map<DateTime, List<dynamic>> events = {};
    QuerySnapshot qn = await FirebaseFirestore.instance.collection('eventos').get();
    var docs = qn.docs;
    if (!user.praticas) {
      docs = docs.where((doc) => doc['pratica'] == false).toList();
    }
    if (!user.ligante) {
      docs = docs.where((doc) => doc['restrictToLigantes'] == false).toList();
    }
    if (!user.extensionista) {
      docs = docs.where((doc) => doc['restrictToExtensionistas'] == false).toList();
    }
    docs.forEach((doc) {
      var date = DateTime.parse((doc['date'] as Timestamp).toDate().toIso8601String().substring(0, 10));
      if (!events.keys.contains(date)) {
        events[date] = [];
      }
      events[date].add(doc);
    });
    setState(() {
      this._events = events;
    });
  }

  _buildCardFromEvent(event) {
    DateTime date = event['date'].toDate();
    var horario = date.hour.toString() + ':' + date.hour.toString();
    return Card(child: Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(children: [
            Text(event['title'], style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
            Text(event['pratica'] ? 'Prática' : ''),
          ],),
          Row(children: [
            Text(horario)
          ],),
          SizedBox(height: 12),
          Row(
            children: [
              Flexible(child: Text(event['description'])) 
            ],
          )
        ]
      )
    ));
  }

}