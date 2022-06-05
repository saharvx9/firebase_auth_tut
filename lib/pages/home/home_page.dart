import 'package:firebase_auth_tut/pages/home/bloc/home_cubit.dart';
import 'package:firebase_auth_tut/pages/home/platform/home_mobile_page.dart';
import 'package:firebase_auth_tut/pages/home/platform/home_other_page.dart';
import 'package:firebase_auth_tut/pages/splash/splash_page.dart';
import 'package:firebase_auth_tut/widgets/dialog/app_dialog.dart';
import 'package:firebase_auth_tut/widgets/dialog/dialog_state.dart';
import 'package:firebase_auth_tut/widgets/theme_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {

  static const routeName = "/home";
  final String id;

  const HomePage({Key? key, required this.id}): super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final cubit = GetIt.I<HomeCubit>();

  @override
  void initState() {
    super.initState();
    cubit.start(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: cubit,
      buildWhen: (prev,next)=> next is LoadingState || next is UserState,
      listener: (context, state) {
        switch(state.runtimeType){
          case ErrorState:
           final dialogState = (state as ErrorState).dialogState;
            AppDialog.displayDialog(context, dialogState, onClick: () => cubit.start(widget.id));
            break;
          case LogOutAwareDialog:
            final dialogState = (state as LogOutAwareDialog).dialogState;
            AppDialog.displayDialog(context, dialogState, onClick: () => cubit.logOut());
            break;
          case LogOutState:
            context.go(SplashPage.routeName);
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        return AnimatedSwitcher(duration: const Duration(milliseconds: 300),
        child: state is UserState ? LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth > 550
              ? HomeOtherPage(user: state.user,logOutClick: () => cubit.displayLogoutDialog())
              : HomeMobilePage(user: state.user, logOutClick: () => cubit.displayLogoutDialog());
            }
        ): const Scaffold(
            appBar: ThemeAppBar(title: "Loading..."),
            body: Center(child: CircularProgressIndicator())));
      },
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
