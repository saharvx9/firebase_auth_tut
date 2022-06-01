import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_tut/pages/error/error_page.dart';
import 'package:firebase_auth_tut/pages/home/bloc/home_cubit.dart';
import 'package:firebase_auth_tut/pages/home/home_page.dart';
import 'package:firebase_auth_tut/pages/login/login_page.dart';
import 'package:firebase_auth_tut/pages/register/registeration_page.dart';
import 'package:firebase_auth_tut/pages/splash/splash_page.dart';
import 'package:firebase_auth_tut/widgets/page_transtion.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter buildRouts() => GoRouter(
          redirect: (state)=> state.path,
          errorBuilder: (context, state) => const ErrorPage(),
          // initialLocation: HomePage.routeName,
          routes: [
            GoRoute(
              path: SplashPage.routeName,
              pageBuilder: (context, state) => PageTransition<void>(
                key: state.pageKey,
                child: SplashPage(cubit: GetIt.I(),),
              ),
            ),
            GoRoute(
              path: RegistrationPage.routeName,
              pageBuilder: (context, state) => PageTransition<void>(
                  key: state.pageKey,
                  transitionDuration: const Duration(seconds: 1),
                  child: RegistrationPage(cubit: GetIt.I()),
                  type: defaultTargetPlatform != TargetPlatform.android || defaultTargetPlatform != TargetPlatform.iOS ? PageTransitionType.leftToRight : PageTransitionType.none),
            ),
            GoRoute(
              path: LoginPage.routeName,
              pageBuilder: (context, state) => PageTransition<void>(
                  key: state.pageKey,
                  child: LoginPage(cubit: GetIt.I()),
                  type: PageTransitionType.bottomToTop),
            ),
            GoRoute(
              name: HomePage.routeName,
              path: "${HomePage.routeName}/:id",
              // redirect: (state){
              //   final localId = FirebaseAuth.instance.currentUser?.uid;
              //   final id = state.params["id"]!;
              //   print("show current id: $id,show local id : $localId,show path: ${state.path}");
              //   if(localId != id) return SplashPage.routeName;
              //   else return state.name;
              // },
              pageBuilder: (context, state) {
                final id = state.params["id"]!;
                return PageTransition<void>(
                  key: state.pageKey,
                  child: HomePage(id: id),
                  alignment: Alignment.center,
                  type: PageTransitionType.scale);
              },
            )
          ]);
}
