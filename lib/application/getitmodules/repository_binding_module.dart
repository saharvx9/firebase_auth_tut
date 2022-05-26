import 'package:firebase_auth_tut/data/prefrences/app_prefrences.dart';
import 'package:firebase_auth_tut/data/source/theme/theme_data_source.dart';
import 'package:firebase_auth_tut/data/source/theme/theme_local_repository.dart';
import 'package:get_it/get_it.dart';

class RepositoryBindingModule {

  static providesModules(){
    _providesThemeRepository();
  }

  static _providesThemeRepository(){
    GetIt.I.registerSingletonWithDependencies<ThemeDataSourceLocal>(() => ThemeLocalRepository(GetIt.I()),dependsOn: [AppPreferences]);
  }
}