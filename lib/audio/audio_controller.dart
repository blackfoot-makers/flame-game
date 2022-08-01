import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';

class AudioController {
  // For now we have to return an AudioCache because we are caching files with
  // AudioPlayers, but in the future it would be better to use FlameAudio's
  // cache system only.
  static Future<AudioCache> cacheAllFiles() async {
    try {
      await FlameAudio.audioCache.loadAll(<String>['ambiance.wav']);
      return AudioCache(prefix: 'assets/audio/');
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

  static AudioPlayer createAudioPlayer(
    String file,
    AudioCache audioCache, {
    double volume = 1.0,
    bool isLoop = false,
  }) {
    try {
      return AudioPlayer(playerId: file)
        ..setVolume(volume)
        ..setReleaseMode(
          isLoop ? ReleaseMode.loop : ReleaseMode.release,
        )
        ..audioCache = audioCache;
    } catch (error) {
      throw Exception('Error creating an AudioPlayer: $error');
    }
  }

  // For the moment, we are using the play function of AudioPlayers and not of
  // FlameAudio, later on, it would be good to use the FlameAudio method to
  // avoid creating an AudioPlayer.
  static void play(
    String file,
    AudioPlayer audioPlayer, {
    bool isLongAudio = false,
  }) {
    try {
      audioPlayer.play(
        AssetSource(file),
        mode: isLongAudio ? PlayerMode.mediaPlayer : PlayerMode.lowLatency,
      );
    } catch (error) {
      throw Exception('Error playing the audio: $error');
    }
  }

  static void stop(AudioPlayer audioPlayer) {
    try {
      audioPlayer.stop();
    } catch (error) {
      throw Exception('Error stoping the audio: $error');
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
