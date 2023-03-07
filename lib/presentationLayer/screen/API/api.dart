// ignore_for_file: prefer_const_constructors, avoid_print, unused_import

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/api_bloc/post_bloc_cubit.dart';
import 'package:task03/blocs/api_bloc/post_states.dart';
import 'package:task03/helper/const/const.dart';
import 'package:task03/helper/const/image_helper.dart';
import 'package:task03/helper/extension/snackbar_helper.dart';
import 'package:task03/helper/const/string_resource.dart';
import 'package:task03/model/post_model.dart';
import 'package:task03/presentationLayer/widget/get_text.dart';
import 'package:task03/presentationLayer/widget/input_field.dart';
import 'package:task03/helper/extension/validation_helper.dart';

class APiScreen extends StatefulWidget {
  const APiScreen({super.key});

  @override
  State<APiScreen> createState() => _APiScreenState();
}

class _APiScreenState extends State<APiScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final _formGlobalKey = GlobalKey<FormState>();
  late List<PostModel> posts;

  @override
  void initState() {
    super.initState();
    context.read<PostCubit>().fetchPosts();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formGlobalKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: K_PADDING,vertical: 5),
        child: Column(
          children: [
            BlocBuilder<PostCubit, PostStates>(
              builder: (context, state) {
                return TextFieldWidget(
                    onChangedVal: ((val) {
                        context.read<PostCubit>().searchPost(val!);
                    }),
                    hintText: StringResources.INPUT_DATA,
                    textEditingController: _textEditingController,
                    validator: (v) =>'$v'.isRequired() ? null : StringResources.REQ_FIELD
                        );
              },
            ),
            const SizedBox(
              height: 17,
            ),
            Flexible(
              child: BlocConsumer<PostCubit, PostStates>(
                listener: (context, state) {
                  if (state.status == PostStatus.failure) {
                    buildErrorSnackbar(context, StringResources.CONNECT_ISSUE);
                  }
                },
                builder: (context, state) {
                  switch (state.status) {
                    case PostStatus.failure:
                      return Center(child:TextWidget(txt:StringResources.ERROR_TEXT));
                    case PostStatus.success:
                      return buildPostListView(state.posts);
                    case PostStatus.initial:
                      return Center(child:CircularProgressIndicator());
                    case PostStatus.searchError:
                      return Center(child:TextWidget(txt:StringResources.NO_DATA));
                    default:
                      return Center(child:TextWidget(txt:StringResources.NO_DATA));
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPostListView(List<PostModel> posts) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        PostModel post = posts[index];
        return ListTile(
          leading: Image.network(ImageClass.networkImage),
          title: TextWidget(txt:post.title.toString()),
          subtitle: TextWidget(txt:post.id.toString()),
        );
      },
    );
  }
}
