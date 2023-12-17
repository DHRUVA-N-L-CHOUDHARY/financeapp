part of 'landing_page_bloc.dart';


sealed class LandingPageState  {
  final int tabIndex;

  const LandingPageState({required this.tabIndex});
}

 class LandingPageInitial extends LandingPageState {
  LandingPageInitial({required super.tabIndex});
}

class LandingPageIndexChanged extends LandingPageState
{
  LandingPageIndexChanged({required super.tabIndex});  
}

class DashBoardPage extends LandingPageState {
  DashBoardPage({required super.tabIndex});
}

class StatisticsPage extends LandingPageState
{
  StatisticsPage({required super.tabIndex});
}

class ProfilePage extends LandingPageState
{
  ProfilePage({required super.tabIndex});
}
class SavingsPage extends LandingPageState
{
  SavingsPage({required super.tabIndex});
}