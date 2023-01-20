// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task03/blocs/hive_bloc/hive_bloc.dart';
import 'package:task03/blocs/api_bloc/post_bloc_cubit.dart';
import 'package:task03/blocs/Navbar_bloc/nav_cubit_state.dart';
import 'package:task03/blocs/firebase_bloc/product_firebase_bloc.dart';
import 'package:task03/helper/const/common_keys.dart';
import 'package:task03/presentationLayer/screen/welcome_screen.dart';
import 'package:task03/repositories/firebaseRepository.dart';
import 'package:task03/repositories/hive_repository.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox(CommonKeys.BOX);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<NavigationCubit>(
      create: (context) => NavigationCubit(),),
      BlocProvider<PostCubit>(create: ((context) => PostCubit())),
      BlocProvider<ProductBloc>(create: ((context) => ProductBloc(prod_repo: FirebaseRepository()))),
      BlocProvider<HiveBloc>(create: ((context) => HiveBloc(hiveRepositry: HiveRepositry()))),

    ]
    ,child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const RootScreen(),
      ),
      );
      
    
  }
}
