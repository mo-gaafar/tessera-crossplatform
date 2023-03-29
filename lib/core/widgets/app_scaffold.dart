import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/authentication/cubit/auth_cubit.dart';

class AppScaffold extends StatelessWidget {
  AppScaffold({super.key, required this.body, this.appBar});

  final Widget body;
  PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Stack(
        alignment: Alignment.center,
        children: [
          body,
          if (context.watch<AuthCubit>().state is Loading)
            const CircularProgressIndicator.adaptive(),
        ],
      ),
    );
  }
}
