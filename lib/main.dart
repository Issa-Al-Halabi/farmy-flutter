import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharma/bloc/tracking_bloc/tracking_bloc.dart';
import 'package:pharma/core/utils/firebase_notifications_handler.dart';
import 'core/services/services_locator.dart';
import 'data/data_resource/local_resource/data_store.dart';
import 'data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'my_app.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  await Firebase.initializeApp();
  await FirebaseNotificationsHandler().init();

  await DataStore.instance.init();
  BaseApiClient();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}
