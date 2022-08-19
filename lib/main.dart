import 'package:bloc_experiment/data/request/select_booking_request.dart';
import 'package:bloc_experiment/data/response/select_booking_response.dart';
import 'package:bloc_experiment/login_screen.dart';
import 'package:bloc_experiment/repository.dart';
import 'package:bloc_experiment/secondScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:hive/hive.dart';

import 'blocs/counter_bloc.dart';
import 'blocs/bloc_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CounterBloc>(
          create: (BuildContext context) => CounterBloc(0)),
      BlocProvider<NumArrayBloc>(
          create: (BuildContext context) => NumArrayBloc([])),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CounterBloc? counterBloc;
  SelectbookingResponse? selectbookingResponse;
  PageController calenderController = PageController();
  List<int> selectedDays=[];
  DateTime? selectedDate=DateTime.now();
  DateTime focusedDay = DateTime.now();

  getAlreadyBookedSlots(DateTime dateTime) async{
    final repo=Repository();
    SelectbookingRequest alreadyBookedSlot=SelectbookingRequest(
        month: dateTime.month.toString(),
        year: dateTime.year.toString()
    );
    final response= await repo.getBookingSlots(alreadyBookedSlot);
    if(response.isSuccess!){
      selectbookingResponse=SelectbookingResponse.fromJson(response.dataResponse);
      selectbookingResponse!.date!.forEach((element) {
        DateTime dateTime=DateTime.parse(element.date!);
        selectedDays.add(dateTime.day);
      });
      Fluttertoast.showToast(msg: selectbookingResponse!.status!.toString());
    }else{
      Fluttertoast.showToast(msg: "something went wrong!!");
    }
  }

  @override
  void initState() {
    getAlreadyBookedSlots(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    counterBloc = BlocProvider.of<CounterBloc>(context);
    return BlocBuilder(
        bloc: counterBloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('TableCalendar Example'),
            ),
            body: Column(
              children: [
                Row(children: [
                  IconButton(
                    onPressed: () {
                      calenderController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                      focusedDay =
                          focusedDay.subtract(const Duration(days: 30));
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.arrow_left,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                  Text(focusedDay.toString().split(" ")[0],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red)),
                  IconButton(
                    onPressed: () {
                      calenderController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );

                      focusedDay = focusedDay.add(const Duration(days: 30));
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.arrow_right,
                      size: 30,
                      color: Colors.red,
                    ),
                  )
                ]),
                Center(
                  child: TableCalendar(
                    focusedDay: focusedDay,
                    firstDay: DateTime(2000, 1, 1),
                    lastDay: DateTime(2050, 1, 1),
                    currentDay: DateTime.now(),
                    calendarFormat: CalendarFormat.month,
                    headerVisible: false,
                    onCalendarCreated: (controller) {
                      calenderController = controller;
                    },
                    enabledDayPredicate: (DateTime date){

                        print("res -> ${selectedDays.contains(date.day)}");
                        return !selectedDays.contains(date.day);

                    },
                    onFormatChanged: (CalendarFormat _format) {},
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    daysOfWeekVisible: true,
                    calendarBuilders: CalendarBuilders(
                      dowBuilder: (context, day) {},
                      markerBuilder: (context, day, events) {
                        return Container(
                          height: 15,
                          width: 15,
                          color: selectedDays.contains(day) ? Colors.red : Colors.green,
                        );
                      },
                    ),
                    onDaySelected: (
                      DateTime selectDay,
                      DateTime focusDay,
                    ) {
                      focusDay = focusDay;
                      selectedDate=selectDay;
                      if(selectedDate==DateTime.now()){
                        Fluttertoast.showToast(msg: "Booking already there");
                      }else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen(dateTime: selectedDate!)),
                        );
                      }

                    },
                    calendarStyle: const CalendarStyle(
                      isTodayHighlighted: true,
                      defaultTextStyle: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 13,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.w600),
                      outsideTextStyle: TextStyle(
                          color: Color(0xFF9F9F9F),
                          fontSize: 12,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.w600),
                      selectedDecoration: BoxDecoration(
                          color: Color(0xFF008800),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 2.5,
                              blurStyle: BlurStyle.normal,
                              color: Color.fromRGBO(102, 187, 102, 0.65),
                            )
                          ]),
                      selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.w900),
                      weekendDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      weekendTextStyle: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 13,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.w600),
                      todayDecoration: BoxDecoration(),
                      todayTextStyle: TextStyle(
                          color: Color(0xFF398500),
                          fontSize: 12,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.w600),
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                    rowHeight: 50.0,
                    daysOfWeekHeight: 25.0,
                    availableGestures: AvailableGestures.all,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                      CalendarFormat.week: 'Week'
                    },
                    onPageChanged: (date) {},
                  ),
                )
              ],
            ),
          );
        });
  }
}
