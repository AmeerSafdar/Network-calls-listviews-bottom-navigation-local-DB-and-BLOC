// ignore_for_file: file_names, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/hive_bloc/hive_bloc.dart';
import 'package:task03/blocs/hive_bloc/hive_events.dart';
import 'package:task03/blocs/hive_bloc/hive_states.dart';
import 'package:task03/helper/const/const.dart';
import 'package:task03/helper/const/string_resource.dart';
import 'package:task03/presentationLayer/widget/get_text.dart';
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

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HiveBloc>(context).add(RetreiveData());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formGlobalKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: K_PADDING,vertical: 5),
        child: Column(
          children: [
            TextFieldWidget(
                hintText: StringResources.INPUT_DATA,
                textEditingController: _textEditingController,
                validator: (v) =>
                    '$v'.isRequired() ? null : StringResources.REQ_FIELD),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<HiveBloc, HiveStates>(
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
                    child:  Text(StringResources.ADD_TEXT));
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Flexible(child: BlocBuilder<HiveBloc, HiveStates>(
              builder: (context, state) {
                if (state.status ==HiveStatus.success ) {
                  if (state.posts.isEmpty) {
                    return Center(child: TextWidget(txt:StringResources.NO_DATA ),);
                  }
                  return buildPostListView(state.posts);
                } else if(state.status == HiveStatus.addingData || state.status == HiveStatus.initial ) {
                  return Center(child: CircularProgressIndicator(),);
                }
                else if(state.status == HiveStatus.failure){
                  return Center(child: TextWidget(txt:StringResources.ERROR_TEXT));
                }
                return Center(child: CircularProgressIndicator());
               
              },
            ))
          ],
        ),
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
              child: TextWidget(txt:"$index:- ${data[index]}"),
            ),
          ),
        );
      },
    );
  }
}
