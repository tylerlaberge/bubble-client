import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybubble/widgets/bubble/bubble.widget.dart';
import 'package:collection/collection.dart';

import '../../bloc/bubble.bloc.dart';
import '../../bloc/events/bubble.state.dart';
import '../../model/bubble.model.dart';

class BubbleFloatView extends StatefulWidget {

  const BubbleFloatView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BubbleFloatState();
}

class _BubbleFloatState extends State<BubbleFloatView> with SingleTickerProviderStateMixin {

  final Map<String, Map<String, double>> _bubblePositions = {};

  Future? _bubblePositionFuture;

  double _calculateContainerSize(List<Bubble> bubbles) {
    return (25 * bubbles.length) + 50 + bubbles
        .fold(0, (size, bubble) => size + min(bubble.data.length * 2.5, 175) + 75);
  }

  void _calculateBubblePositions(List<Bubble> bubbles) {
    bubbles.forEachIndexed((index, bubble) {
      if (index == 0) {
        _bubblePositions.putIfAbsent(bubble.id, () => {
          "left": Random().nextInt(25) + 100,
          "top": Random().nextInt(25) + 25
        });
      } else {
        var prevBubble = bubbles[index - 1];
        var prevPosition = _bubblePositions[prevBubble.id]!;
        _bubblePositions.putIfAbsent(bubble.id, () => {
          "left": index % 2 == 0 ? Random().nextInt(25) + 100 : Random().nextInt(25) + 100,
          "top": prevPosition["top"]! + min(prevBubble.data.length * 2.5, 175) + 100
        });
      }
    });
  }

  void _continuouslyUpdateBubblePositions(List<Bubble> bubbles) {
    _calculateBubblePositions(bubbles);
    _bubblePositionFuture ??= Future.delayed(const Duration(seconds: 4), () {
        setState(() {
          _bubblePositions.clear();
          _calculateBubblePositions(bubbles);
          _bubblePositionFuture = null;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<BubbleBloc, BubbleState>(
       builder: (context, state) {
         _continuouslyUpdateBubblePositions(state.bubbles);
         return Container(
           decoration: const BoxDecoration(
             image: DecorationImage(
               fit: BoxFit.cover,
               image: AssetImage("assets/images/white_background.jpg")
             )
           ),
           child: SingleChildScrollView(
             child: Stack(
                 children: state.bubbles.mapIndexed<Widget>((index, bubble) {
                   return AnimatedPositioned(
                       duration: const Duration(seconds: 4),
                       curve: Curves.linear,
                       top: _bubblePositions[bubble.id]!["top"],
                       left: _bubblePositions[bubble.id]!["left"],
                       child: BubbleWidget(bubble)
                   );
                 }).toList()..add(Container(height: _calculateContainerSize(state.bubbles)))
             )
           )
         );
       }
    );
  }
}