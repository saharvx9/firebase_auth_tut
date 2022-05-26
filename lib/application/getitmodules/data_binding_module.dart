import 'package:firebase_auth_tut/data/prefrences/app_prefrences.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataBindingModule {

  static providesModules(){
    _providesPreferencesModule();
  }

  static _providesPreferencesModule(){
    GetIt.I.registerSingletonAsync(() async  {
      final prefs = await SharedPreferences.getInstance();
      return AppPreferences(prefs);
    });
  }

}