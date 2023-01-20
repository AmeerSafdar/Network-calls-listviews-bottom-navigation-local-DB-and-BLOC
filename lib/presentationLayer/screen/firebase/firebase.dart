// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_full_hex_values_for_flutter_colors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/firebase_bloc/firebase_state.dart';
import 'package:task03/blocs/firebase_bloc/product_firebase_bloc.dart';
import 'package:task03/blocs/firebase_bloc/products_firebase_events.dart';
import 'package:task03/helper/const/const.dart';
import 'package:task03/helper/const/string_resource.dart';
import 'package:task03/helper/extension/validation_helper.dart';
import 'package:task03/model/product_model.dart';
import 'package:task03/presentationLayer/widget/get_text.dart';
import 'package:task03/presentationLayer/widget/input_field.dart';

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
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:K_PADDING,vertical: 5),
          child: Column(
            children: [
              TextFieldWidget(
                  hintText: StringResources.INPUT_DATA,
                  textEditingController: _nameController,
                  validator: (v) =>
                      '$v'.isRequired() ? null : StringResources.REQ_FIELD),
              SizedBox(
                height: 12,
              ),
              BlocBuilder<ProductBloc, ProductStates>(
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
                    child: TextWidget(txt:StringResources.ADD_TEXT),
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
              Flexible(child: BlocBuilder<ProductBloc, ProductStates>(
                  builder: ((context, state) {
                if (state.status ==ProductStatus.productAdding) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == ProductStatus.failure) {
                  return Center(
                    child:TextWidget(txt:StringResources.ERROR_TEXT),
                  );
                }
                if (state.status == ProductStatus.initial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status ==ProductStatus.success) {
                  List<ProductModel> my_Data = state.posts;
                  if (my_Data.isEmpty) {
                    return Center(child: TextWidget(txt:StringResources.NO_DATA ),);
                  }
                  return ListView.builder(
                      itemCount: my_Data.length,
                      itemBuilder: ((_, index) {
                        return Card(
                          child: ListTile(
                            title: TextWidget(txt:"$index :- ${my_Data[index].name}"),
                          ),
                        );
                      }));
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              })))
            ],
          ),
        ));
  }

}
