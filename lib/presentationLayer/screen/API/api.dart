// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/post_bloc_cubit.dart';
import 'package:task03/blocs/post_state.dart';
import 'package:task03/model/post_model.dart';
import 'package:task03/widget/input_field.dart';
import 'package:task03/const/validation_helper.dart';

class APiScreen extends StatefulWidget {
  const APiScreen({super.key});

  @override
  State<APiScreen> createState() => _APiScreenState();
}

class _APiScreenState extends State<APiScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final _formGlobalKey = GlobalKey<FormState>();

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
              hintText: 'Input Data',
              textEditingController: _textEditingController,
              validator: (v) =>
                  '$v'.isRequired() ? null : 'Input field is required'),
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<PostCubit, PostState>(
            builder: (context, state) {
              return ElevatedButton(
                  onPressed: () {
                    if (_formGlobalKey.currentState!.validate()) { 
                      context.read<PostCubit>().searchPost(_textEditingController.text);
                    }
                  },
                  child: const Text('Search'))
                  ;
            },
          ),
          SizedBox(
            height: 8,
          ),
          Flexible(
            child: BlocConsumer<PostCubit, PostState>(
              listener: (context, state) {
                if (state is PostErrorState) {
                  SnackBar snackBar = SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              builder: (context, state) {
                if (state is PostLoadingState || state is PostSearchingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(state is PostSearchingErrorState){
                  return Center(child: Text('No data found'),);
                }
                if (state is PostSearchedState) {
                  return buildPostListView(state.posts);
                }
                if (state is PostLoadedState) {
                  return buildPostListView(state.posts);
                }

                return Center(
                  child: Text("An error occured!"),
                );
              },
            ),
          ),
        ],
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
          // leading: Image.network('${post.thumbnailUrl}'),
          leading: Image.network(
              "https://images.pexels.com/photos/2820884/pexels-photo-2820884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
          title: Text(post.title.toString()),
          subtitle: Text(post.id.toString()),
        );
      },
    );
  }
}
