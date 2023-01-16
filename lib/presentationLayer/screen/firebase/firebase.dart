// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_full_hex_values_for_flutter_colors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/product_firebase_bloc.dart';
import 'package:task03/blocs/product_firebase_state.dart';
import 'package:task03/blocs/products_firebase_events.dart';
import 'package:task03/const/validation_helper.dart';
import 'package:task03/model/product_model.dart';
import 'package:task03/widget/input_field.dart';

class FirebaseScreen extends StatefulWidget {
  const FirebaseScreen({super.key});

  @override
  State<FirebaseScreen> createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  final TextEditingController _nameController = TextEditingController();
  final _formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(GetData());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formGlobalKey,
        child: Container(
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFieldWidget(
                    hintText: 'Input Data',
                    textEditingController: _nameController,
                    validator: (v) =>
                        '$v'.isRequired() ? null : 'Input field is required'),
                SizedBox(
                  height: 5,
                ),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () async{
                        if (_formGlobalKey.currentState!.validate())  {
                          BlocProvider.of<ProductBloc>(context).add(Create(_nameController.text));
                          await Future.delayed(const Duration(seconds: 1));
                          BlocProvider.of<ProductBloc>(context).add(GetData());
                          _nameController.text='';
                        }
                      },
                      child:state is ProductAdding ? CircularProgressIndicator(color: Color(0xffffff),):  Text('Add'),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(child: BlocBuilder<ProductBloc, ProductState>(
                    builder: ((context, state) {
                  if (state is ProductAdding) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProductError) {
                    return Center(
                      child: Text('Eroor'),
                    );
                  }
                  if (state is ProductLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProductLoaded) {
                    List<ProductModel> my_Data = state.myData;
                    return ListView.builder(
                        itemCount: my_Data.length,
                        itemBuilder: ((_, index) {
                          return Card(
                            child: ListTile(
                              title: Text("$index :- ${my_Data[index].name}"),
                            ),
                          );
                        }));
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })))
              ],
            )));
  }

}
