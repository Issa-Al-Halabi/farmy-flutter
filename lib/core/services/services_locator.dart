import 'package:get_it/get_it.dart';
import 'package:pharma/bloc/authentication_bloc/authertication_bloc.dart';
import 'package:pharma/bloc/language_bloc/language_bloc.dart';


final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    sl.registerLazySingleton(() => AuthenticationBloc());
    sl.registerLazySingleton(() => LanguageBloc());
  }
}
