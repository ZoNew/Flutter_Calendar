import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Calendar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _firstDay = DateTime(1998, DateTime.september, 1);
  DateTime _lastDay = DateTime(2022, DateTime.december, 31);

  DateTime _selectedDay = DateTime.now();

  //TODO : infinite scroll
  //final dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final _suggestions = <DateTime>[];

  // final _biggerFont = TextStyle(fontSize: 18.0);

  //TODO : Bind calendar with list view

  @override
  void initState() {
    super.initState();
    /*controller = RCalendarController.multiple(selectedDates: [
      DateTime(2019, 12, 1),
      DateTime(2019, 12, 2),
      DateTime(2019, 12, 3),
    ]);*/
    /*controller = RCalendarController.single(
      selectedDate: DateTime.now().toUtc(),
      isAutoSelect: true,
    );*/
    /*controller =  RCalendarController.single(
        initialData: [
          DateTime.now(),
          DateTime.now().add(Duration(days: 1)),
          DateTime.now().add(Duration(days: 2)),
        ]
    );*/
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildCalendar(),
          // ListView inside Column MUST Wrap
          Expanded(
            child: _buildSuggestions(),
          ),
        ],
      ),
    );
  }

  Container _buildCalendar() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: TableCalendar(
        // calendarBuilders: ,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: Colors.cyan,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: Colors.cyan,
          ),
        ),
        focusedDay: _focusedDay,
        firstDay: _firstDay,
        lastDay: _lastDay,

        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },

        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
          });
        },
          /*_suggestions.clear();
          _suggestions.add(_selectedDay);*//*
        },*/
        /*calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          selectedDecoration:
              BoxDecoration(color: Colors.cyan, shape: BoxShape.circle),
          selectedTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),*/
        /*onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },*/

        /*selectedDayPredicate: (day) =>isSameDay(day, selectedDay),*/
        // currentDay: date,
      ),
    );
  }

  ListView _buildSuggestions() {
    return ListView.builder(
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider();
        /*2*/

        final index = i ~/ 2; /*3*/
        var addList= _selectedDay;
        if (index >= _suggestions.length) {
          addList = DateTime.now().add(Duration(days: index));
          _suggestions.add(addList); /*4*/

        }
        DateTime dateIndex = _suggestions[index];
        return _buildRow(dateIndex);
      },
    );
  }

  Widget _buildRow(DateTime date) {
    return Container(
      child: ListTile(
        title: Text(
          DateFormat('yyyy-MM-dd').format(date),
          style: TextStyle(
            fontSize: 18,
            color: Colors.cyan.shade400,
          ),
        ),
        onTap: () {
          print(date);
          setState(() {
            _focusedDay = date;
            _selectedDay = date;
          });
        },
      ),
    );
  }
}
