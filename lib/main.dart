// ignore_for_file: library_private_types_in_public_api
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:sked/models/modelo_funcion.dart';
import 'package:sked/models/modelo_api_data.dart';
import 'package:sked/models/modelo_futura_pelicula.dart';
import 'package:sked/models/modelo_pelicula.dart';
import 'package:http/http.dart' as http;
import 'package:sked/models/modelo_visita.dart';
import 'package:sked/pages/home.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataModel extends ChangeNotifier {
  ModeloAPIData? _data;
  ModeloAPIData? get data => _data;

  String apiURL = String.fromEnvironment('API_URL',
      defaultValue: '${dotenv.env["API_URL"]}');

  List<ModeloPelicula> parseMovies(String responseBody) {
    List<dynamic> jsonData = json.decode(responseBody);
    return jsonData.map((json) => ModeloPelicula.fromJson(json)).toList();
  }

  List<ModeloFuturaPelicula> parseFutureMovies(String responseBody) {
    List<dynamic> jsonData = json.decode(responseBody);
    return jsonData.map((json) => ModeloFuturaPelicula.fromJson(json)).toList();
  }

  void updateFunctionsAndVisits() async {
    final responseFunctions = await http.get(Uri.parse('$apiURL/funciones'));
    _data!.funciones = List.of(parseFunctions(responseFunctions.body));

    final responsePictures = await http.get(Uri.parse('$apiURL/fotosVisitas'));
    _data!.fotosVisitas = List.of(parsePictures(responsePictures.body));

    notifyListeners();
  }

  List<ModeloFuncion> parseFunctions(String responseBody) {
    List<dynamic> jsonData = json.decode(responseBody);
    return jsonData.map((json) => ModeloFuncion.fromJson(json)).toList();
  }

  List<dynamic> parsePictures(String responseBody) {
    return json.decode(responseBody);
  }

  List<ModeloVisita> parseVisits(String responseBody) {
    List<dynamic> jsonData = json.decode(responseBody);
    return jsonData.map((json) => ModeloVisita.fromJson(json)).toList();
  }

  Future<ModeloAPIData> fetchDataFromAPI() async {
    try {
      if (_data != null) {
        return _data!;
      }
      _data = ModeloAPIData();

      final responseMovies = await http.get(Uri.parse('$apiURL/cartelera'));
      final responseFutureMovies =
          await http.get(Uri.parse('$apiURL/proximamente'));
      final responseFunctions = await http.get(Uri.parse('$apiURL/funciones'));
      final responsePictures =
          await http.get(Uri.parse('$apiURL/fotosVisitas'));
      final responseVisits = await http.get(Uri.parse('$apiURL/visitas'));

      if (responseMovies.statusCode == 200 &&
          responseFutureMovies.statusCode == 200 &&
          responseFunctions.statusCode == 200 &&
          responsePictures.statusCode == 200 &&
          responseVisits.statusCode == 200) {
        _data!.cartelera = List.of(parseMovies(responseMovies.body));
        _data!.proximamente =
            List.of(parseFutureMovies(responseFutureMovies.body));
        _data!.funciones = List.of(parseFunctions(responseFunctions.body));
        _data!.fotosVisitas = parsePictures(responsePictures.body);
        _data!.visitas = List.of(parseVisits(responseVisits.body));

        notifyListeners();

        if (_data!.funciones!.isNotEmpty) {
          tz.initializeTimeZones();
          tz.setLocalLocation(tz.getLocation('America/Lima'));

          String dateString =
              '${_data!.funciones?[0].functionDate} ${_data!.funciones?[0].functionTime}';

          DateTime dateTime = DateTime.parse(dateString);

          tz.TZDateTime functionDate = tz.TZDateTime(
            tz.local,
            dateTime.year,
            dateTime.month,
            dateTime.day,
            dateTime.hour,
            dateTime.minute,
          );

          tz.TZDateTime scheduledDate =
              functionDate.subtract(const Duration(hours: 24));

          FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
              FlutterLocalNotificationsPlugin();
          const AndroidNotificationDetails androidNotificationDetails =
              AndroidNotificationDetails(
            'phone',
            'Phone',
            channelDescription: 'User device',
            importance: Importance.max,
            priority: Priority.high,
          );
          const DarwinNotificationDetails darwinNotificationDetails =
              DarwinNotificationDetails();
          const NotificationDetails notificationDetails = NotificationDetails(
              android: androidNotificationDetails,
              iOS: darwinNotificationDetails);

          if (!scheduledDate.isBefore(DateTime.now())) {
            await flutterLocalNotificationsPlugin.zonedSchedule(
              0,
              '¡Película mañana!',
              '${_data!.funciones?[0].title}'
                  " \u2022 "
                  '${_data!.funciones?[0].functionTime}',
              scheduledDate,
              notificationDetails,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime,
            );
          }
        }

        return _data!;
      } else {
        throw Exception(
            'Failed to retrieve movies! Status code: ${responseMovies.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching movies xdd: $error');
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future:
            Provider.of<DataModel>(context, listen: false).fetchDataFromAPI(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: <Color>[
                      Color(0xFFFF9900),
                      Color(0xFFBF001D),
                      Color(0xFFA50F3D),
                      Color(0xFF143A6B),
                      Color(0xFF1F5286),
                      Color(0xFF008DFF)
                    ],
                        stops: <double>[
                      0,
                      0.2,
                      0.33,
                      0.7,
                      0.82,
                      1
                    ])),
                child: const Center(
                    child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 6,
                  ),
                )));
          } else if (snapshot.hasError) {
            return Text("Error XD: ${snapshot.error}");
          } else if (!snapshot.hasData) {
            return const Text("No data available!");
          } else {
            return const Home();
          }
        },
      ),
      theme: ThemeData(fontFamily: 'Avenir'),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  if (!Platform.environment.containsKey('API_URL')) {
    await dotenv.load(fileName: ".env");
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification:
              (int id, String? title, String? body, String? payload) async {});
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  runApp(
    ChangeNotifierProvider(create: (_) => DataModel(), child: const MyApp()),
  );
}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload: $payload');
  }
}
