import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybubble/bloc/events/bubble.event.dart';
import 'package:mybubble/bloc/events/bubble.state.dart';
import 'package:mybubble/bloc/bubble.bloc.dart';
import 'package:flutter/material.dart';
import 'package:mybubble/environment.dart';
import 'package:mybubble/model/location.model.dart';
import 'package:mybubble/theme.dart';
import 'package:mybubble/widgets/bubble/bubble_list_view.widget.dart';

import 'model/bubble.model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      home: BlocProvider(
        create: (_) => BubbleBloc()
          ..add(BubbleLoadEvent(
            Bubble(
                id: Environment.bubbleId,
                data: "Tyler's Bubble",
                location: Location(latitude: 45.253786, longitude: -69.445476)
            )
          )),
        child: const HomePage(),
      ));
  }
}

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bubble", style: Theme.of(context).textTheme.headline5)
        ),
        body: BlocBuilder<BubbleBloc, BubbleState>(
          builder: (context, state) => BubbleListView(state.bubbles)
        )
    );
  }
}
