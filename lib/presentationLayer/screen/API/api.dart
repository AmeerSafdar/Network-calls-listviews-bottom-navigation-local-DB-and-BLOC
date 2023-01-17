// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/api_bloc/post_bloc_cubit.dart';
import 'package:task03/blocs/states.dart';
import 'package:task03/helper/extension/color_helper.dart';
import 'package:task03/helper/extension/image_helper.dart';
import 'package:task03/helper/extension/snackbar_helper.dart';
import 'package:task03/helper/extension/string_helper.dart';
import 'package:task03/model/post_model.dart';
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
  final StringHelper _stringHelper=StringHelper();

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
          BlocBuilder<PostCubit, ProductState>(
            builder: (context, state) {
              return ElevatedButton(
                  onPressed: () {
                    if (_formGlobalKey.currentState!.validate() && state is PostLoadedState) { 
                      context.read<PostCubit>().searchPost(_textEditingController.text, state.posts);
                    }
                  },
                  child: _stringHelper.getStringText(SEARCH_TEXT)  )
                  ;
            },
          ),
          SizedBox(
            height: 8,
          ),
          Flexible(
            child: BlocConsumer<PostCubit, ProductState>(
              listener: (context, state) {
                if (state is PostErrorState) {
                  buildErrorSnackbar(context, 'check your internet connection');
                }
              },
              builder: (context, state) {
                if (state is PostLoadingState || state is PostSearchingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(state is PostSearchingErrorState){
                  return Center(child:  _stringHelper.getStringText(ERROR_TEXT),);
                }
                if (state is PostSearchedState) {
                  return buildPostListView(state.posts);
                }
                if (state is PostLoadedState) {
                  return buildPostListView(state.posts);
                }

                return Center(
                  child:  _stringHelper.getStringText(ERROR_TEXT),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPostListView(List<PostModel> posts) {
    ImageClass img=ImageClass();
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        PostModel post = posts[index];
        return ListTile(
          // leading: img.getImage('${post.thumbnailUrl}'),
          leading:img.getImage("https://images.pexels.com/photos/2820884/pexels-photo-2820884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
          title: _stringHelper.getStringText(post.title.toString()),
          subtitle:_stringHelper.getStringText(post.id.toString()),
        );
      },
    );
  }
}
