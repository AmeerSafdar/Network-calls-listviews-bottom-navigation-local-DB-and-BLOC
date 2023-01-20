// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/Navbar_bloc/nav_cubit_state.dart';
import 'package:task03/helper/const/icon_helper.dart';
import 'package:task03/helper/const/string_resource.dart';
import 'package:task03/presentationLayer/screen/API/api.dart';
import 'package:task03/presentationLayer/screen/firebase/firebase.dart';
import 'package:task03/presentationLayer/screen/localHiveDB/localDB.dart';
import 'package:task03/presentationLayer/widget/get_text.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(txt:StringResources.TASK_3),
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            showUnselectedLabels: false,
            items:  [
              BottomNavigationBarItem(
                icon:
                  IconHelper.HOME_ICON,
                label: StringResources.FIREBASE,
              ),
              BottomNavigationBarItem(
                icon:IconHelper.SETTING_ICON,
                label: StringResources.API,
              ),
              BottomNavigationBarItem(
                icon:IconHelper.PERSON_ICON,
                label: StringResources.HIVE,
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.home);
              } else if (index == 1) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.settings);
              } else if (index == 2) {
                BlocProvider.of<NavigationCubit>(context)
                    .getNavBarItem(NavbarItem.profile);
              }
            },
          );
        },
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        if (state.navbarItem == NavbarItem.home) {
          return FirebaseScreen();
        } else if (state.navbarItem == NavbarItem.settings) {
          return APiScreen();
        } else if (state.navbarItem == NavbarItem.profile) {
          return LocalDBHive();
        }
        return Container();
      }),
    );
  }
}