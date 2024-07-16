import 'dart:io';

import 'package:flutter/material.dart';
import 'package:harmony_hive/backend/backend.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerProvider extends ChangeNotifier {
  // Songs Records List
  late List<SongsRecord> songsList;
  late SongsRecord newSongsList;
  int songIndex = 0;

  // controllers
  AudioPlayer? playerCenter;
  AudioPlayer? playerleft;
  AudioPlayer? playerRight;
  AudioPlayer? playerTop;
  AudioPlayer? playerBottom;

  // sleekbar
  String duration = '';
  String position = '';
  double maxDuration = 0.0;
  double currentProgress = 0.0;

  // Song details
  String songTitle = '';
  String songArtist = '';

  // indicators
  bool songIsPlaying = false;
  ValueNotifier<bool> buffering = ValueNotifier(false);
  ValueNotifier<bool> showSmallAudioController = ValueNotifier(false);

  // cursor position
  double left = 120.0;
  double top = 120.0;

  // Buffer message
  String bufferMessage = 'Loading song...';

  initilizeSongs(
    int index,
  ) async {
    // If old song is already playing, It will stop all songs and free resourses
    if (songIsPlaying) {
      stopSongs();
    }

    // getting Song number from list of songs
    songIndex = index;

    // audio detail shown on the slider
    duration = '';
    position = '';

    //! Initilizng audio player if not initilize
    playerCenter ??= AudioPlayer();
    playerleft ??= AudioPlayer();
    playerRight ??= AudioPlayer();
    playerTop ??= AudioPlayer();
    playerBottom ??= AudioPlayer();

    //! Requesting song data from server
    bufferSongs();
  }

  bufferSongs() async {
    // update the screen first
    notifyListeners();
    // Buffering all 5 songs before play
    try {
      buffering.value = true;
      await playerCenter!.setUrl(songsList[songIndex].centerUrl).then((_) {
        return playerCenter!.load();
      });
      await playerleft!.setUrl(songsList[songIndex].leftUrl).then((_) {
        return playerleft!.load();
      });

      await playerRight!.setUrl(songsList[songIndex].rightUrl).then((_) {
        return playerRight!.load();
      });
      await playerTop!.setUrl(songsList[songIndex].topUrl).then((_) {
        return playerTop!.load();
      });

      await playerBottom!.setUrl(songsList[songIndex].bottomUrl).then((_) {
        return playerBottom!.load();
      });

      playerTop!.seek(const Duration(milliseconds: 124));
      playerRight!.seek(const Duration(milliseconds: 93));
      playerBottom!.seek(const Duration(milliseconds: 87));
      playerleft!.seek(const Duration(milliseconds: 140));
      playerCenter!.seek(const Duration(milliseconds: 200));

      // setting initial volume
      playerCenter!.setVolume(1);
      playerleft!.setVolume(0);
      playerRight!.setVolume(0);
      playerTop!.setVolume(0);
      playerBottom!.setVolume(0);

      // Changing cursor position back to center
      left = 120;
      top = 120;

      buffering.value = false;

      // Everything is ready and song is ready to play
      playSongs();

      // Will listen to error if comes during song playing
      //listenPlayBackError();

      notifyListeners();
    } on PlayerException catch (e) {
      // iOS/macOS: maps to NSError.code
      // Android: maps to ExoPlayerException.type
      // Web: maps to MediaError.code
      // Linux/Windows: maps to PlayerErrorCode.index
      print('this is playeerrrrrr exception');
      //changeBufferMessage(e.message ?? "Something went wrong");
      // iOS/macOS: maps to NSError.localizedDescription
      // Android: maps to ExoPlaybackException.getMessage()
      // Web/Linux: a generic message
      // Windows: MediaPlayerError.message
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      // This call was interrupted since another audio source was loaded or the
      // player was stopped or disposed before this audio source could complete
      // loading.
      print('this is network exception');
      //changeBufferMessage("Lost connection to the internet");
      print("Connection aborted: ${e.message}");
    } catch (e) {
      // Fallback for all other errors
      //changeBufferMessage("Something went wrongt");
      print('An error occured: $e');
    }
  }

  // will change volume control position
  void changeCursorPosition(DragUpdateDetails value) {
    left += value.delta.dx;
    top += value.delta.dy;
    double x = left;
    double y = top;
    if (left < 0) {
      left = 0;
    }
    if (top < 0) {
      top = 0;
    }
    // Constrain on the right side
    if (left > 300 - 60) {
      left = 240;
    }

    // Constrain on the bottom side
    if (top > 300 - 60) {
      top = 240;
    }

    x = x.clamp(0.0, 240.0);
    y = y.clamp(0.0, 240.0);
    print("X axis $left");
    print("Y axis $top");

    // print("+ X cords ${x / 120}");
    if (left <= 120) {
      double negativeX = double.parse((1 - x / 120).abs().toStringAsFixed(1));
      print("left volume ${(1 - x / 120).abs()}");
      playerleft!.setVolume(negativeX);
      notifyListeners();
    }
    if (left >= 120) {
      double posativeX = double.parse((1 - x / 120).abs().toStringAsFixed(1));
      print("right volume ${(1 - x / 120).abs()}");
      playerRight!.setVolume(posativeX);
      notifyListeners();
    }
    if (top <= 120) {
      double negativeY = double.parse((1 - y / 120).abs().toStringAsFixed(1));
      print("top volume ${(1 - y / 120).abs()}");

      playerTop!.setVolume(negativeY);
      notifyListeners();
    }
    if (top >= 120) {
      double posativeY = double.parse((1 - y / 120).abs().toStringAsFixed(1));
      print("bottom volume ${(1 - y / 120).abs()}");
      playerBottom!.setVolume(posativeY);
      notifyListeners();
    }
  }

  playSongs() async {
    if (!buffering.value) {
      await Future.delayed(const Duration(milliseconds: 1000));
      playerRight!.play();
      playerleft!.play();
      playerCenter!.play();
      playerTop!.play();
      playerBottom!.play();

      //await Future.delayed(const Duration(milliseconds: 800));
      //playerCenter!.play();

      // center is playing in last

      songIsPlaying = true;
      notifyListeners();
      updatePosition();
    }
  }

  pausSongs() async {
    await playerleft!.pause();
    await playerRight!.pause();
    await playerCenter!.pause();
    await playerTop!.pause();
    await playerBottom!.pause();
    notifyListeners();
    songIsPlaying = false;
  }

  stopSongs() async {
    currentProgress = 0.0;
    duration = '';
    position = '';
    maxDuration = 0.0;
    await playerTop!.pause();
    await playerRight!.pause();
    await playerBottom!.pause();
    await playerleft!.pause();
    await playerCenter!.pause();

    playerTop!.seek(const Duration(milliseconds: 124));
    playerRight!.seek(const Duration(milliseconds: 93));
    playerBottom!.seek(const Duration(milliseconds: 87));
    playerleft!.seek(const Duration(milliseconds: 140));
    playerCenter!.seek(const Duration(milliseconds: 200));
    notifyListeners();
    songIsPlaying = false;
  }

  disposePlayer() async {
    await playerleft!.dispose();
    await playerRight!.dispose();
    await playerCenter!.dispose();
    await playerTop!.dispose();
    await playerBottom!.dispose();
    currentProgress = 0.0;
    duration = '';
    position = '';
    maxDuration = 0.0;
    notifyListeners();
    songIsPlaying = false;
  }

  // change sleekbar position as the song is playing
  updatePosition() async {
    //If the song is playing for the first time, then we will calculate its duartion
    playerCenter!.durationStream.listen((d) {
      duration = d.toString().split(".")[0];

      maxDuration = d!.inSeconds.toDouble();

      notifyListeners();
    });

    playerCenter!.positionStream.listen((p) {
      position = p.toString().split(".")[0];
      currentProgress = p.inSeconds.toDouble();

      notifyListeners();
    });
  }

  // Seek Song in seconds
  changeDurationToSeconds(secons) async {
    try {
      if (songIsPlaying) {
        await pausSongs();
      }
      var duration = Duration(seconds: secons);
      await playerleft!.seek(duration);
      await playerRight!.seek(duration);
      await playerCenter!.seek(duration);
      await playerTop!.seek(duration);
      await playerBottom!.seek(duration);
      await Future.delayed(const Duration(milliseconds: 500));
      await playSongs();
      notifyListeners();
    } catch (e) {
      changeBufferMessage('Something went wrong');
    }
  }

  void changeBufferMessage(String message) {
    bufferMessage = message;
    notifyListeners();
    buffering.value = true;
  }

  void listenPlayBackError() {
    playerCenter!.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace st) {
      if (e is PlayerException) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
        changeBufferMessage(e.message ?? "Something went wrong");
      } else {
        changeBufferMessage("Something went wrong");
        print('An error occurred: $e');
      }
    });
  }

  skipToNextSong() {
    print(songsList.length);
    print(songIndex);
    if (songIndex < songsList.length - 1) {
      songIndex++;
      print(songIndex);
      initilizeSongs(songIndex);
    } else {
      songIndex = 0;
      print(songIndex);
      initilizeSongs(songIndex);
    }
  }

  skipToPreviousSong() {
    print(songsList.length);
    if (songIndex > 0) {
      songIndex--;
      print(songIndex);
      initilizeSongs(songIndex);
    } else {
      songIndex = songsList.length - 1;
      print(songIndex);
      initilizeSongs(songIndex);
    }
  }
}
