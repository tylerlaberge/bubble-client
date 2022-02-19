import 'package:flutter/material.dart';

import '../../model/bubble.model.dart';
import 'bubble_list_item.widget.dart';

class BubbleList  extends StatelessWidget {

  final List<Bubble> bubbles;

  const BubbleList(this.bubbles, {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: bubbles.map((bubble) {
        return BubbleListItem(bubble);
      }).toList(),
    );
  }
}