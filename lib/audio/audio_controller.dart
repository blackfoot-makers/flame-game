import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';

class AudioController {
  Future<void> cacheAllFiles() async {
    try {
      await FlameAudio.audioCache.loadAll(<String>['ambiance.wav', 'run.wav']);
    } catch (error) {
      throw Exception('Error caching the audio files: $error');
    }
  }

  Future<void> changeLogLevel({bool debug = false}) async {
    try {
      await AudioPlayer.global
          .changeLogLevel(debug ? LogLevel.info : LogLevel.error);
    } catch (error) {
      throw Exception('Error changing the log level: $error');
    }
  }

  void initializeBackgroundMusic() {
    try {
      FlameAudio.bgm.initialize();
    } catch (error) {
      throw Exception('Error initializing the background music: $error');
    }
  }

  Future<void> playBackgroundMusic(String file, {double volume = 1.0}) async {
    try {
      await FlameAudio.bgm.play(file, volume: volume);
    } catch (error) {
      throw Exception('Error playing the background music: $error');
    }
  }

  void disposeBackgroundMusic() {
    try {
      FlameAudio.bgm.dispose();
    } catch (error) {
      throw Exception('Error disposing the background music: $error');
    }
  }

  // https://docs.flame-engine.org/main/flame_audio/audio_pool.html
  Future<AudioPool> createPool(String filename) async {
    try {
      return AudioPool.create(
        filename,
        maxPlayers: 1,
      );
    } catch (error) {
      throw Exception('Error creating the audio pool: $error');
    }
  }

  // TODO(alex): Fix this method
  Future<AudioPlayer> play(
    String file, {
    bool isLongAudio = false,
    double volume = 1.0,
  }) async {
    try {
      return isLongAudio
          ? await FlameAudio.playLongAudio(file, volume: volume)
          : await FlameAudio.play(file, volume: volume);
    } catch (error) {
      throw Exception('Error playing the audio: $error');
    }
  }

  // TODO(alex): Fix this method
  Future<AudioPlayer> loop(
    String file, {
    bool isLongAudio = false,
    double volume = 1.0,
  }) async {
    try {
      return isLongAudio
          ? await FlameAudio.loopLongAudio(file, volume: volume)
          : await FlameAudio.loop(file, volume: volume);
    } catch (error) {
      throw Exception('Error looping the audio: $error');
    }
  }

  AudioPlayer createAudioPlayer(String file, {double volume = 1.0}) {
    try {
      return AudioPlayer(playerId: file)..setVolume(volume);
    } catch (error) {
      throw Exception('Error creating an AudioPlayer: $error');
    }
  }
}
