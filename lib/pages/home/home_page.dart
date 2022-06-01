import 'package:firebase_auth_tut/pages/home/bloc/home_cubit.dart';
import 'package:firebase_auth_tut/pages/home/platform/home_mobile_page.dart';
import 'package:firebase_auth_tut/pages/home/platform/home_other_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
      listener: (context, state) {

      },
      builder: (context, state) {
        print("ui ${cubit.hashCode}");
        return AnimatedSwitcher(duration: const Duration(milliseconds: 300),
        child: state is UserState ? LayoutBuilder(
            builder: (context, constraints) => constraints.maxWidth > 550
              ? HomeOtherPage(user: state.user,logOutClick: ()=> cubit.logOut(),)
              : HomeMobilePage(user: state.user)
        ): const CircularProgressIndicator());
      },
    );
  }

  @override
  void dispose() {
    // widget.cubit.close();
    super.dispose();
  }
}
//941146523