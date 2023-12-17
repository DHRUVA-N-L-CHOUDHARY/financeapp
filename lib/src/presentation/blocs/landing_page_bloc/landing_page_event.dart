part of 'landing_page_bloc.dart';

abstract class LandingPageEvent  {}

class TabChange extends LandingPageEvent {
  final int tabIndex;
  TabChange({required this.tabIndex});
}
