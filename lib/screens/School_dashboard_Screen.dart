import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_3/assets/global_values.dart';
import 'package:flutter_application_3/assets/models/Tarea_model.dart';
import 'package:flutter_application_3/database/schooldb.dart';
import 'package:flutter_application_3/widgets/CardTareaWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';


class SchoolDashboardScreen extends StatefulWidget {
  const SchoolDashboardScreen({super.key});

  @override
  State<SchoolDashboardScreen> createState() => _SchoolDashboardScreenState();
}


class _SchoolDashboardScreenState extends State<SchoolDashboardScreen> {
  SchoolDB? schoolDB;
DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final Map<DateTime, List<TareaModel>> _events = {};
  List<String> listDates = [];
  List<TareaModel> listTasks = [];
  
   @override
  void initState() {
    super.initState();
    schoolDB = SchoolDB();
    fetchTaskData();

    
  }
  Future<void> fetchTaskData() async {
    listTasks = await schoolDB!.GETALLTASK3();
    List<TareaModel> listTask = await schoolDB!.GETALLTASK3();
    setState(() {
      for (var task in listTask) {
        final taskDate = DateTime.parse(task.fecExpiracion!);
        if (_events.containsKey(taskDate)) {
          _events[taskDate]!.add(task);
          //debugPrint('Notification Scheduled for $taskDate');
        } else {
          _events[taskDate] = [task];
          debugPrint('xdd');
        }
      }
    }); 
    _updateCalendar();
  }
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              List<Widget> dots = [];
              final dateFormat = DateTime.parse(DateFormat('yyyy-MM-dd').format(day));
              final events = _events[dateFormat] ?? [];
              dots = events.map((event) {
                return Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                );
              }).toList();
              // if (day == _selectedDay) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: dots,
                );
              // } else {
              //   return null;
              // }
            },
          ),

            locale: "en_US",
            rowHeight: 45,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true
            ),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = selectedDay;
                _selectedDay = selectedDay;
                _updateCalendar(); 
              });
            },
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: GlobalValues.flagTarea,
              builder: (context, value, _) {
                return FutureBuilder(
                  future: schoolDB!.getTaskByDate(_selectedDay.toString().substring(0, 10)),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<TareaModel>> snapshot
                    ) {
                      if(snapshot.hasData) {
                        listTasks = snapshot.data!;
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CardTareaWidget(
                              tareaModel: snapshot.data![index],
                              schoolDB: schoolDB,
                            );
                          }
                        );
                      } else {
                        if(snapshot.hasError) {
                          return const Center(
                            child: Text('Something was wrong!'),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }
                    }
                );
              }
            ),
          ),
        ],
      ),
       drawer: createDrawer()
    );
  }



  Widget createDrawer() {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/giphy.gif'),
            ),
            accountName: Text(
              'JUAN',
              style: Theme.of(context).textTheme.headline6,
            ),
            accountEmail: Text(
              'JUAN@gmail.com',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ListTile(
            leading: SizedBox(
              width: 50.0, // Ancho deseado
              height: 50.0, // Alto deseado
              child: Image.asset('assets/IconCarrera.png'),
            ),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('CARRERA',
                style: TextStyle(color: Colors.black, fontSize: 19.0)),
            subtitle: Text(
              'Administracion de Carreras',
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            onTap: () async{
              Navigator.pushNamed(context, '/carrera');
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50.0, // Ancho deseado
              height: 50.0, // Alto deseado
              child: Image.asset(
                'assets/IconMaestro.png',
                height: 50,
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            title: Text(
              'MAESTRO',
              style: TextStyle(color: Colors.black, fontSize: 19.0),
            ),
            subtitle: Text(
              'Administracion de Maestros',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            onTap: ()async {
              Navigator.pushNamed(context, '/profesor');
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50.0, // Ancho deseado
              height: 50.0, // Alto deseado
              child: Image.asset('assets/IconHomeworks.png'),
            ),
            trailing: const Icon(Icons.chevron_right),
            title: Text(
              'TAREA',
              style: TextStyle(color: Colors.black, fontSize: 19.0),
            ),
            subtitle: Text(
              'Adminitracion de Tareas',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            onTap: () async {
              Navigator.pushNamed(context, '/tarea');
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0),
            child: DayNightSwitcher(
              isDarkModeEnabled: GlobalValues.flagTheme.value,
              onStateChanged: (isDarkModeEnabled) async {
                GlobalValues.flagTheme.value = isDarkModeEnabled;

                // Guarda el estado del tema en SharedPreferences
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.setBool('isDarkModeEnabled', isDarkModeEnabled);
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 100.0, vertical: 200),
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                    Size(100.0, 30)), // Ancho máximo del botón
              ),
              onPressed: () async {
                Navigator.pushNamed(context, '/dash');
              },
              child: Text('EXIT'),
            ),
          )
        ],
      ),
    );
  }


List<String> _getEventsForDay(DateTime day) {
  // Obtén las tareas para el día especificado
  String formattedDate = '${day.day}-${day.month}-${day.year}';
  List<String> events = [];  // Agrega tu lógica para obtener tareas para la fecha especificada
  // Aquí, obtendrías las tareas para formattedDate y las agregarías a la lista de eventos

  return events;
}

List<String> _onDaySelected(DateTime day) {
  // Obtén las tareas para el día especificado
  String formattedDate = '${day.day}-${day.month}-${day.year}';
  List<String> events = [];  // Agrega tu lógica para obtener tareas para la fecha especificada
  // Aquí, obtendrías las tareas para formattedDate y las agregarías a la lista de eventos

  return events;
}


void _updateCalendar() {
  setState(() {
    // Este setState forzará la reconstrucción del widget
  });
}
}
