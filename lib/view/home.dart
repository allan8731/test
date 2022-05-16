import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repopractice/viewModel/homeVC.dart';

class Home extends HookConsumerWidget {
  //todo:: switch ConsumerWidget to HookConsumerWidget
  const Home({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // useEffect(() {
    //   // print(1);
    //   //todo:: start api request hear
    //   //1. make provider for data to save
    //   //2. make method part for "users", "posts", "todos"
    //   //3. during 1 to 2 use codebuilder
    // },[]);
    return Scaffold(
      appBar: AppBar(actions: const [
        ButtonConsumer(str: 'users'),
        ButtonConsumer(
          str: 'posts',
        ),
        ButtonConsumer(
          str: 'todos',
        ),
      ]),
      body:ApiDataConsumer()
    );
  }
}

class ButtonConsumer extends HookConsumerWidget {
  final String str;

  const ButtonConsumer({Key? key, required this.str}) : super(key: key);

  //todo first:: pass str props to widget without riverpod provider nor createState
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() => null,[]);
    //todo make button class for users,posts,...
    // throw UnimplementedError();
    return Consumer(builder: (context, ref, child) {
      return ElevatedButton(
        //todo::why use this button style? just pick it up among latest 3 types of button
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.deepPurple;
              }
              return Colors.blue;
            },
          ),
        ),
        onPressed: () {
          return ref
              //todo what's diff btw watch and read?
              .watch(apiDataProvider.notifier)
              // .generate(endpoint: "users", dio: Dio());
              .generate(endpoint: str);
        },
        child: str==null?Text('no Data'):Text("$str Data"),
      );
    });
  }
}

class ApiDataConsumer extends ConsumerWidget {
  const ApiDataConsumer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///todo how to describe data for clients using Widget, which one?? why??
    var show = ref.watch(apiDataProvider);
    // print(show.runtimeType);
    // return Text("${show.runtimeType}");
    // throw UnimplementedError();

    if(show.runtimeType==List<dynamic>){
      return Text("no data");
    }else  return
      ListView(
      children: [ShowData(show).widgetShow()],
    );
  }
}

class ShowData {
  var show;
  ShowData(this.show);

  widgetShow(){
    return Text("${show.map((x){return x.id;})}");
  }
}