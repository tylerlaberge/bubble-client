import '../../model/bubble.model.dart';

abstract class BubbleEvent {}

class BubbleLoadEvent extends BubbleEvent {
  final Bubble bubble;
  BubbleLoadEvent(this.bubble);
}

class BubbleEnterEvent extends BubbleEvent {
  final Bubble bubble;
  BubbleEnterEvent(this.bubble);
}

class BubbleErrorEvent extends BubbleEvent {
  final dynamic error;
  BubbleErrorEvent(this.error);
}