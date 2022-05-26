import 'package:firebase_auth_tut/pages/error/error_page.dart';
import 'package:firebase_auth_tut/pages/home/home_page.dart';
import 'package:firebase_auth_tut/pages/login/login_page.dart';
import 'package:firebase_auth_tut/pages/register/registeration_page.dart';
import 'package:firebase_auth_tut/pages/splash/splash_page.dart';
import 'package:firebase_auth_tut/widgets/page_transtion.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter buildRouts() => GoRouter(
          redirect: (state)=> state.path,
          errorPageBuilder: (context, state) => PageTransition<void>(
              child: const ErrorPage(), type: PageTransitionType.scale),
          initialLocation: RegistrationPage.routeName,
          routes: [
            GoRoute(
              path: SplashPage.routeName,
              pageBuilder: (context, state) => PageTransition<void>(
                key: state.pageKey,
                child: const SplashPage(),
              ),
            ),
            GoRoute(
              path: RegistrationPage.routeName,
              pageBuilder: (context, state) => PageTransition<void>(
                  key: state.pageKey,
                  child: RegistrationPage(cubit: GetIt.I(),),
                  type: PageTransitionType.leftToRight),
            ),
            GoRoute(
              path: LoginPage.routeName,
              pageBuilder: (context, state) => PageTransition<void>(
                  key: state.pageKey,
                  child: const LoginPage(),
                  type: PageTransitionType.bottomToTop),
            ),
            GoRoute(
              path: HomePage.routeName,
              pageBuilder: (context, state) => PageTransition<void>(
                  key: state.pageKey,
                  child: const HomePage(),
                  type: PageTransitionType.scale),
            )
          ]);
}
