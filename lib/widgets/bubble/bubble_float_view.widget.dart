import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybubble/widgets/bubble/bubble.widget.dart';
import 'package:collection/collection.dart';

import '../../bloc/bubble.bloc.dart';
import '../../bloc/events/bubble.state.dart';

class BubbleFloatView extends StatefulWidget {

  const BubbleFloatView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BubbleFloatState();
}

class _BubbleFloatState extends State<BubbleFloatView> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  final Map<String, Map<String, double>> _bubblePositions = {};

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        reverseDuration: const Duration(seconds: 3)
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<BubbleBloc, BubbleState>(
       builder: (context, state) {
         return SingleChildScrollView(
             child: Stack(
                 children: state.bubbles.mapIndexed<Widget>((index, bubble) {
                   _bubblePositions.putIfAbsent(bubble.id, () => {
                     "left": index % 2 == 0 ? Random().nextInt(25) + 25 : Random().nextInt(25) + 150,
                     "top": (index * 200) + (index * 25) + Random().nextInt(25) + 25
                   });
                   Future.delayed(const Duration(seconds: 3), () {
                     setState(() {
                       _bubblePositions[bubble.id]!["left"] = index % 2 == 0 ? Random().nextInt(25) + 25 : Random().nextInt(25) + 150;
                       _bubblePositions[bubble.id]!["top"] = (index * 200) + (index * 25) + Random().nextInt(25) + 25;

                     });
                   });
                   return AnimatedPositioned(
                       duration: const Duration(seconds: 3),
                       curve: Curves.linear,
                       top: _bubblePositions[bubble.id]!["top"],
                       left: _bubblePositions[bubble.id]!["left"],
                       child: BubbleWidget(bubble),
                   );
                 }).toList()..add(Container(height: (state.bubbles.length * 200) + (state.bubbles.length * 25) + 25))
             )
         );
       }
    );
  }
}