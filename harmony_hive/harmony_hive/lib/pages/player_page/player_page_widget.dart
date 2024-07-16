import 'package:harmony_hive/pages/player_page/widgets/moveable_stack_item.dart';
import 'package:harmony_hive/pages/provider/audio_player_provider.dart';
import 'package:harmony_hive/utils/globals.dart';
import 'package:just_audio/just_audio.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'player_page_model.dart';
export 'player_page_model.dart';

class PlayerPageWidget extends StatefulWidget {
  const PlayerPageWidget({
    super.key,
    this.index,
    required this.noInitilizeSongsAgain,
  });
  final bool noInitilizeSongsAgain;
  final int? index;

  @override
  _PlayerPageWidgetState createState() => _PlayerPageWidgetState();
}

class _PlayerPageWidgetState extends State<PlayerPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  AudioPlayerProvider audioPlayerProvider = sl();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.noInitilizeSongsAgain) {
        audioPlayerProvider.initilizeSongs(widget.index!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return WillPopScope(
      onWillPop: () async {
        if (audioPlayerProvider.songIsPlaying) {
          audioPlayerProvider.showSmallAudioController.value = true;
        }
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
            top: true,
            child: ChangeNotifierProvider.value(
              value: audioPlayerProvider,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).accent1,
                      FlutterFlowTheme.of(context).accent2,
                      FlutterFlowTheme.of(context).accent3
                    ],
                    stops: const [0.0, 0.2, 1.0],
                    begin: const AlignmentDirectional(0.98, 1.0),
                    end: const AlignmentDirectional(-0.98, -1.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 23, vertical: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (audioPlayerProvider.songIsPlaying) {
                                  audioPlayerProvider
                                      .showSmallAudioController.value = true;
                                }
                                context.safePop();
                              },
                              child: CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.white.withOpacity(.5),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 6),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox.shrink(),

                      //! Upper controller -------------------------------------->
                      Consumer<AudioPlayerProvider>(
                        builder: (context, value, child) {
                          return SizedBox(
                            height: 300,
                            width: 300,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color(0xff222222),
                                    ),
                                    height: 300,
                                    width: 300,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: const RadialGradient(
                                            radius: 0.6,
                                            colors: [
                                              Color(0xff7F7F7F),
                                              Colors.transparent
                                            ])),
                                    height: 300,
                                    width: 300,
                                    child: const Stack(
                                      children: [MoveableStackItem()],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Transform.rotate(
                                    angle: 3.14159 / 2,
                                    child: Text(
                                      audioPlayerProvider
                                          .songsList[
                                              audioPlayerProvider.songIndex]
                                          .leftTitle
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(.5)),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Transform.rotate(
                                    angle: 3.14159 / 2,
                                    child: Text(
                                      audioPlayerProvider
                                          .songsList[
                                              audioPlayerProvider.songIndex]
                                          .rightTitle
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(.5)),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 18),
                                    child: Text(
                                      audioPlayerProvider
                                          .songsList[
                                              audioPlayerProvider.songIndex]
                                          .topTitle
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(.5)),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 18),
                                    child: Text(
                                      audioPlayerProvider
                                          .songsList[
                                              audioPlayerProvider.songIndex]
                                          .bottomTitle
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(.5)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Consumer<AudioPlayerProvider>(
                        builder: (context, value, child) {
                          return SizedBox(
                            height: 350,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Text(
                                  audioPlayerProvider
                                      .songsList[audioPlayerProvider.songIndex]
                                      .title,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                Text(
                                  audioPlayerProvider
                                      .songsList[audioPlayerProvider.songIndex]
                                      .artist,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Row(
                                    children: [
                                      Text(audioPlayerProvider.position,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white)),
                                      Expanded(
                                          child: Slider(
                                        onChanged: (value) {},
                                        min: const Duration(seconds: 0)
                                            .inSeconds
                                            .toDouble(),
                                        max: audioPlayerProvider.maxDuration,
                                        thumbColor: Colors.white,
                                        inactiveColor: Colors.grey,
                                        activeColor: Colors.white,
                                        value:
                                            audioPlayerProvider.currentProgress,
                                        onChangeEnd: (progress) {
                                          audioPlayerProvider
                                              .changeDurationToSeconds(
                                                  progress.toInt());
                                        },
                                      )),
                                      Text(audioPlayerProvider.duration,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                ValueListenableBuilder(
                                  valueListenable:
                                      audioPlayerProvider.buffering,
                                  builder: (context, value, child) {
                                    if (value) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              const CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                audioPlayerProvider
                                                    .bufferMessage,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              audioPlayerProvider
                                                  .skipToNextSong();
                                            },
                                            child: const Icon(
                                              Icons.skip_previous,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.white,
                                            child: audioPlayerProvider
                                                    .songIsPlaying
                                                ? GestureDetector(
                                                    onTap: () {
                                                      audioPlayerProvider
                                                          .pausSongs();
                                                    },
                                                    child: const Icon(
                                                      size: 35,
                                                      Icons.pause,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      audioPlayerProvider
                                                          .playSongs();
                                                    },
                                                    child: const Icon(
                                                      size: 35,
                                                      Icons.play_arrow,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              audioPlayerProvider
                                                  .skipToNextSong();
                                            },
                                            child: const Icon(
                                              Icons.skip_next,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
