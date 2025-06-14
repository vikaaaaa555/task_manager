import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/options/localization/l10n.dart';
import '../../bloc/home/home_bloc.dart';
import 'home_screen.dart';

class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        switch (state) {
          case HomeInitial():
            context.read<HomeBloc>().add(LoadTasksFromDBEvent());
            return const Center(child: CircularProgressIndicator());
          case HomeLoading():
            return const Center(child: CircularProgressIndicator());
          case HomeTasksLoadSuccess():
            return HomeScreen(tasks: state.tasks);
          case HomeError():
            return Center(
              child: Text(S.of(context).errorMessage(state.message as Object)),
            );
          default:
            return Center(child: Text(S.of(context).unexpectedError));
        }
      },
    );
  }
}
