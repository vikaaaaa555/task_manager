import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home/home_bloc.dart';
import 'home_screen.dart';

class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
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
            return Center(child: Text(state.message));
        }
      },
    );
  }
}
