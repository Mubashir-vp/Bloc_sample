part of 'counter_bloc_bloc.dart';

@immutable
abstract class CounterEvent {}

class CountIncreament extends CounterEvent {}

class CountDecreament extends CounterEvent {}