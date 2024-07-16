import 'package:flutter/material.dart';
import 'package:harmony_hive/pages/provider/audio_player_provider.dart';
import 'package:harmony_hive/utils/globals.dart';
import 'package:provider/provider.dart';

class MoveableStackItem extends StatefulWidget {
  const MoveableStackItem({super.key});

  @override
  State<MoveableStackItem> createState() => _MoveableStackItemState();
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  AudioPlayerProvider audioPlayerProvider = sl();

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerProvider>(
      builder: (context, value, child) {
        return Positioned(
          left: audioPlayerProvider.left,
          top: audioPlayerProvider.top,
          child: GestureDetector(
            onPanUpdate: (value) {
              audioPlayerProvider.changeCursorPosition(value);
            },
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: const BoxDecoration(
                  color: Color(0xff7F7F7F),
                  shape: BoxShape.circle,
                  border: Border(
                      bottom: BorderSide(width: 2, color: Colors.white),
                      top: BorderSide(width: 2, color: Colors.white),
                      left: BorderSide(width: 2, color: Colors.white),
                      right: BorderSide(width: 2, color: Colors.white))),
            ),
          ),
        );
      },
    );
  }
}
