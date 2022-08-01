import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_game/audio/audio_constants.dart';

// For the moment, we are using the play function of AudioPlayers and not of
// FlameAudio, later on, it would be good to use the FlameAudio method to
// avoid creating an AudioPlayer.
class Audio {
  const Audio(this.file, this.audioCache, {this.isLoop = false});

  final String file;
  final AudioCache audioCache;
  final bool isLoop;

  AudioPlayer get audioPlayer {
    return AudioPlayer(playerId: file)
      ..setReleaseMode(isLoop ? ReleaseMode.loop : ReleaseMode.release)
      ..audioCache = audioCache;
  }

  void play() {
    try {
      audioPlayer.play(AssetSource(file));
    } catch (error) {
      throw Exception('Error playing the audio: $error');
    }
  }

  void stop() {
    try {
      audioPlayer.stop();
    } catch (error) {
      throw Exception('Error stoping the audio: $error');
    }
  }

  void dispose() {
    try {
      audioPlayer.dispose();
    } catch (error) {
      throw Exception('Error disposing the audio: $error');
    }
  }
}

class AudioController {
  static AudioCache audioCache = AudioCache(prefix: kAudioPath);

  static Audio playerRunningAudio = Audio(
    kAudioRunningFile,
    audioCache,
    isLoop: true,
  );

  // For now we have to return an AudioCache because we are caching files with
  // AudioPlayers, but in the future it would be better to use FlameAudio's
  // cache system only.
  static Future<void> cacheAllFiles() async {
    try {
      await FlameAudio.audioCache.loadAll(<String>[kAudioAmbianceFile]);
    } catch (error) {
      throw Exception('Error caching the audio files: $error');
    }
  }

  static Future<void> changeLogLevel({bool debug = false}) async {
    try {
      await AudioPlayer.global
          .changeLogLevel(debug ? LogLevel.info : LogLevel.error);
    } catch (error) {
      throw Exception('Error changing the log level: $error');
    }
  }

  static void initializeBackgroundMusic() {
    try {
      FlameAudio.bgm.initialize();
    } catch (error) {
      throw Exception('Error initializing the background music: $error');
    }
  }

  static Future<void> playBackgroundMusic(
    String file, {
    double volume = 1.0,
  }) async {
    try {
      await FlameAudio.bgm.play(file, volume: volume);
    } catch (error) {
      throw Exception('Error playing the background music: $error');
    }
  }

  static void disposeBackgroundMusic() {
    try {
      FlameAudio.bgm.dispose();
    } catch (error) {
      throw Exception('Error disposing the background music: $error');
    }
  }

  // The AudioPool is convenient and functional for sfx type sounds, like a
  // gunshot. https://docs.flame-engine.org/main/flame_audio/audio_pool.html
  static Future<AudioPool> createPool(String filename) async {
    try {
      return AudioPool.create(
        filename,
        maxPlayers: 1,
      );
    } catch (error) {
      throw Exception('Error creating the audio pool: $error');
    }
  }
}
