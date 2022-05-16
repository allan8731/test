import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repopractice/model/api_client.dart';

//import model
import 'package:repopractice/model/user.dart';
import 'package:repopractice/model/post.dart';
import 'package:repopractice/model/todo.dart';

class ApiDataGenerator extends StateNotifier {
  //todo how to deal with initial state?
  //1. let it just be [] and control view using ture?A:B method
  //2. put initial value through generator
  //3. or......
  ApiDataGenerator(List state) : super(state);

  void generate({required String endpoint}) async {
    //todo serialize data and make model subscribes this one
    final dio = Dio();
    final client = Api_client(dio);
    if (endpoint == "users") {
      state = await client.getUsers();
      // print(state);
    } else if (endpoint == "todos") {
      state = await client.getTodos();
      // print(state);
    } else {
      state = await client.getPosts();
      // print(state);
    }

    // final data = await dio.get(
    //     "https://jsonplaceholder.typicode.com/$endpoint");
    // final responseBody = data.data;
    // state = [...responseBody];
  }
}

final apiDataProvider =
    StateNotifierProvider((ref) => ApiDataGenerator(["inital"]));
