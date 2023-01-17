// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum NavbarItem { home, settings, profile }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(NavbarItem.home, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.home:
        emit(NavigationState(NavbarItem.home, 0));
        break;
      case NavbarItem.settings:
        emit(NavigationState(NavbarItem.settings, 1));
        break;
      case NavbarItem.profile:
        emit(NavigationState(NavbarItem.profile, 2));
        break;
    }
  }
}


class NavigationState extends Equatable {
  final NavbarItem navbarItem;
  final int index;

  const NavigationState(this.navbarItem, this.index);

  @override
  List<Object> get props => [this.navbarItem, this.index];
}