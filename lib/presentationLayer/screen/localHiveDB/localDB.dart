// ignore_for_file: file_names, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/hive_bloc/hive_bloc.dart';
import 'package:task03/blocs/hive_bloc/hive_events.dart';
import 'package:task03/blocs/states.dart';
import 'package:task03/helper/extension/string_helper.dart';
import 'package:task03/presentationLayer/widget/input_field.dart';
import 'package:task03/helper/extension/validation_helper.dart';

class LocalDBHive extends StatefulWidget {
  const LocalDBHive({super.key});

  @override
  State<LocalDBHive> createState() => _LocalDBHiveState();
}

class _LocalDBHiveState extends State<LocalDBHive> {
  final TextEditingController _textEditingController = TextEditingController();
  final _formGlobalKey = GlobalKey<FormState>();
  final StringHelper _stringHelper=StringHelper();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HiveBloc>(context).add(RetreiveData());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formGlobalKey,
      child: Column(
        children: [
          TextFieldWidget(
              hintText: INPUT_DATA,
              textEditingController: _textEditingController,
              validator: (v) =>
                  '$v'.isRequired() ? null : REQ_FIELD),
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<HiveBloc, ProductState>(
            builder: (context, state) {
              return ElevatedButton(
                  onPressed: () async {
                    if (_formGlobalKey.currentState!.validate()) {
                      BlocProvider.of<HiveBloc>(context)
                          .add(AddData(_textEditingController.text));
                      _textEditingController.text = '';
                      await Future.delayed(const Duration(seconds: 1));
                      BlocProvider.of<HiveBloc>(context).add(RetreiveData());
                    }
                  },
                  child:  Text(ADD_TEXT));
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Flexible(child: BlocBuilder<HiveBloc, ProductState>(
            builder: (context, state) {
              if (state is DataLoaded) {
                return buildPostListView(state.myData);
              } else if(state is DataAdding) {
                return Center(child: CircularProgressIndicator(),);
              }
              else if(state is DataError){
                return Center(child: _stringHelper.getStringText('ERROR'));
              }
              return Center(child: CircularProgressIndicator());
             
            },
          ))
        ],
      ),
    );
  }

  Widget buildPostListView(List data) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _stringHelper.getStringText("$index:- ${data[index]}"),
            ),
          ),
        );
      },
    );
  }
}
