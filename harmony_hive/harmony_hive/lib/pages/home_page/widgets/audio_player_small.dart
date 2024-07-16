// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:harmony_hive/flutter_flow/flutter_flow_util.dart';
import 'package:harmony_hive/pages/provider/audio_player_provider.dart';
import 'package:harmony_hive/utils/globals.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class AudioPlayerSmall extends StatefulWidget {
  const AudioPlayerSmall({super.key});

  @override
  State<AudioPlayerSmall> createState() => _AudioPlayerSmallState();
}

class _AudioPlayerSmallState extends State<AudioPlayerSmall> {
  AudioPlayerProvider audioPlayerProvider = sl();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: audioPlayerProvider,
      child: Consumer<AudioPlayerProvider>(
        builder: (context, provider, child) {
          return GestureDetector(
            onTap: () {
              context.pushNamed(
                'playerPage',
                queryParameters: {
                  'noInitilizeSongs': serializeParam(
                    true,
                    ParamType.bool,
                  ),
                }.withoutNulls,
              );
            },
            child: Container(
              alignment: Alignment.center,
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        provider.songsList[provider.songIndex].title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        provider.songsList[provider.songIndex].artist,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          audioPlayerProvider.skipToPreviousSong();
                        },
                        child: const Icon(
                          Icons.skip_previous,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                      provider.songIsPlaying
                          ? GestureDetector(
                              onTap: () {
                                provider.pausSongs();
                              },
                              child: const Icon(
                                Icons.pause,
                                size: 35,
                                color: Colors.white,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                provider.playSongs();
                              },
                              child: const Icon(
                                Icons.play_arrow,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                      GestureDetector(
                        onTap: () {
                          audioPlayerProvider.skipToNextSong();
                        },
                        child: const Icon(
                          Icons.skip_next,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
