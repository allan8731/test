import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repopractice/viewModel/homeVC.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends HookConsumerWidget {
  //todo:: switch ConsumerWidget to HookConsumerWidget
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            ApiDataConsumer()
            // ref.read(apiDataProvider.notifier).state.length>0? ApiDataConsumer():Text('no data'),
          ],
        ),
      ),
    );
  }
}

class ButtonConsumer extends ConsumerWidget {
  final String str;

  const ButtonConsumer({Key? key, required this.str}) : super(key: key);

  //todo first:: pass str props to widget without riverpod provider nor createState
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //todo make button class for users,posts,...
    // throw UnimplementedError();
    return Consumer(builder: (context, ref, child) {
      return ElevatedButton(
        //why use this button style? just pick it up among latest 3 types of button
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
              .generate(endpoint: "users", dio: Dio());
        },
        child: const Text("Users Data"),
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
    return Text(show.toString());
    // throw UnimplementedError();
  }
}
