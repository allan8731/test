
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//import model
import 'package:repopractice/model/user.dart';
import 'package:repopractice/model/post.dart';
import 'package:repopractice/model/todo.dart';

class ApiDataGenerator extends StateNotifier {
  //todo how to deal with initial state?
  //1. let it just be [] and control view using ture?A:B method
  //2. put initial value through generator
  //3. or......
  ApiDataGenerator(String state) : super(state);

  void generate({required String endpoint, required dio}) async {
    //todo serialize data and make model subscribes this one
    final data = await dio.get(
        "https://jsonplaceholder.typicode.com/$endpoint");
    final responseBody = data.data;
    state = [...responseBody];
  }
}

final apiDataProvider = StateNotifierProvider((ref) => ApiDataGenerator("users"));