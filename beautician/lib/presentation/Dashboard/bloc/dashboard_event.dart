part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}
class DashboardInitialEvent extends DashboardEvent {}

class DashboardOpenServicePageEvent extends DashboardEvent {}

class DashboardOpenDirectionPageEvent extends DashboardEvent {}

class DashboardOpenChatPageEvent extends DashboardEvent {}

class DashboardOpenCallCustomerEvent extends DashboardEvent{}

class DashboardOpenLeavePageEvent extends DashboardEvent{}

class DashboardOpenTrainingPageEvent extends DashboardEvent{}

class DashboardOpenDashboardPageEvent extends DashboardEvent{}