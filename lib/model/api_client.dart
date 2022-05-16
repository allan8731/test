import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repopractice/model/post.dart';
import 'package:repopractice/model/todo.dart';
import 'package:repopractice/model/user.dart';
import 'package:retrofit/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

// final apiClentProvider = Provider((ref) => Api_client(ref.read));

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")

abstract class Api_client{
  // factory Api_client(Reader reader) => _Api_client(reader(dioProvider));
  factory Api_client(Dio dio, {String baseUrl}) = _Api_client;

  @GET("users")
  Future<List<User>> getUsers();
  @GET("posts")
  Future<List<Post>> getPosts();
  @GET("todos")
  Future<List<Todo>> getTodos();

}
