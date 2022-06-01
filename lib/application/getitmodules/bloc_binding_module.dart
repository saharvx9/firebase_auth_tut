import 'package:firebase_auth_tut/pages/bloc/theme/theme_cubit.dart';
import 'package:firebase_auth_tut/pages/home/bloc/home_cubit.dart';
import 'package:firebase_auth_tut/pages/login/bloc/login_cubit.dart';
import 'package:firebase_auth_tut/pages/splash/splash_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../data/source/theme/theme_data_source.dart';
import '../../pages/register/bloc/registration_cubit.dart';

class BlocBindingModule {

  static providesModules(){
    GetIt.I.registerFactory(() => SplashCubit());
    GetIt.I.registerFactory(() => RegistrationCubit());
    GetIt.I.registerFactory(() => LoginCubit());
    GetIt.I.registerFactory(() => HomeCubit());
    GetIt.I.registerSingletonWithDependencies(() => ThemeCubit(GetIt.I()),dependsOn:[ThemeDataSourceLocal]);
  }

}