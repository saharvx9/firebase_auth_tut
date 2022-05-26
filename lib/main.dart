import 'package:firebase_auth_tut/pages/bloc/theme/theme_cubit.dart';
import 'package:firebase_auth_tut/routes.dart';
import 'package:firebase_auth_tut/pages/app_theme.dart';
import 'package:firebase_auth_tut/utils/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'application/getitmodules/bloc_binding_module.dart';
import 'application/getitmodules/data_binding_module.dart';
import 'application/getitmodules/repository_binding_module.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _injectModules();
  await GetIt.I.allReady();
  final routes = AppRouter.buildRouts();
  runApp(MyApp(routes: routes));
}

void _injectModules() {
  DataBindingModule.providesModules();
  RepositoryBindingModule.providesModules();
  BlocBindingModule.providesModules();
}

class MyApp extends StatelessWidget {
  final GoRouter routes;
  const MyApp({Key? key,required this.routes}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context, fromMaterialApp: true);
    return BlocBuilder<ThemeCubit, SelectedTheme>(
      bloc: GetIt.I<ThemeCubit>(),
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: routes.routeInformationParser,
          routerDelegate: routes.routerDelegate,
          theme: AppTheme(state.brightness).theme,
        );
      },
    );
  }
}
