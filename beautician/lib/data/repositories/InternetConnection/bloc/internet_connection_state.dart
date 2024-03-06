part of 'internet_connection_bloc.dart';

@immutable
abstract class InternetConnectionState {}

class InternetConnectionInitialState extends InternetConnectionState {}

class InternetConnectionLossState extends InternetConnectionState{}

class InternetConnectionGainedState extends InternetConnectionState{}

