part of 'internet_connection_bloc.dart';

@immutable
abstract class InternetConnectionEvent {}

class InternetConnectionInitialEvent extends InternetConnectionEvent{}

class InternetConnectionGainedEvent extends InternetConnectionEvent{}

class InternetConnectionLossEvent extends InternetConnectionEvent{}


