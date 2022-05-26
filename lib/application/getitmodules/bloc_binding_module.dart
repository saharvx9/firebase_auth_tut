import 'package:firebase_auth_tut/pages/bloc/theme/theme_cubit.dart';
import 'package:firebase_auth_tut/pages/splash/splash_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../data/source/theme/theme_data_source.dart';

class BlocBindingModule {

  static providesModules(){
    GetIt.I.registerFactory(() => SplashCubit());
    GetIt.I.registerSingletonWithDependencies(() => ThemeCubit(GetIt.I()),dependsOn:[ThemeDataSourceLocal]);
  }

}