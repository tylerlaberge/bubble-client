import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mybubble/environment.dart';
import 'package:mybubble/model/bubble.model.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';

import 'events/bubble.event.dart';
import 'events/bubble.state.dart';

class BubbleBloc extends Bloc<BubbleEvent, BubbleState> {

  StompClient? _stompClient;

  BubbleBloc() : super(BubbleInActiveState()) {
    on<BubbleLoadEvent>((event, emit) {
      _activateBubble(event.bubble);
      emit(BubbleActiveState([]));
    });
    on<BubbleEnterEvent>((event, emit)  {
        emit(
            BubbleActiveState(
                List
                  .from(state.bubbles.where((bubble) => bubble.id != event.bubble.id))
                  ..add(event.bubble)
            )
        );
    });
    on<BubbleErrorEvent>((event, emit) => debugPrint(event.error.toString()));
  }

  void _activateBubble(Bubble bubble) {
    try {
      _stompClient = StompClient(config: StompConfig(
          url: 'ws://${Environment.serverHost}:${Environment.serverPort}/ws',
          onConnect: (frame) {
            try {
              _stompClient!.subscribe(
                  destination: '/topic/bubble/${bubble.id}',
                  callback: (event) => add(BubbleEnterEvent(Bubble.fromJson(json.decode(event.body!))))
              );
              _postUpdate(bubble);
              // Schedule.interval(() => _postUpdate(bubble), const Duration(seconds: 5));
            } catch (e) {
              add(BubbleErrorEvent(e));
            }
          },
          onWebSocketError: (e) {
            add(BubbleErrorEvent(e));
          }
      ));
      _stompClient!.activate();
    } catch (e) {
      add(BubbleErrorEvent(e));
    }
  }

  void _postUpdate(Bubble bubble) {
    try {
      _stompClient!.send(
          destination: '/queue/bubble',
          body: json.encode(bubble.toJson())
      );
    } catch (e) {
      add(BubbleErrorEvent(e));
    }
  }
}