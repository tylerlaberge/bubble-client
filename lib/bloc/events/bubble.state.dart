import '../../model/bubble.model.dart';

abstract class BubbleState {
  List<Bubble> get bubbles;
}

class BubbleInActiveState extends BubbleState {
  @override
  List<Bubble> get bubbles => [];
}

class BubbleActiveState extends BubbleState {

  final List<Bubble> _bubbles;

  BubbleActiveState(this._bubbles);

  @override
  List<Bubble> get bubbles => _bubbles;
}