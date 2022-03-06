import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocks/bloc/counter_bloc_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: GestureDetector(
            onTap: () => context.read<CounterBloc>().add(
                  CountIncreament(),
                ),
            onDoubleTap: () => context.read<CounterBloc>().add(
                  CountDecreament(),
                ),
            child: const Icon(
              Icons.calculate,
              size: 40,
              color: Colors.greenAccent,
            ),
          ),
          body: Center(
            child: Text(
              state.toString(),
            ),
          ),
        );
      },
    );
  }
}
