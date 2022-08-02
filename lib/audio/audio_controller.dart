import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_game/audio/audio_constants.dart';
import 'package:flame_game/main_game/constant.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// For the moment, we are using the play function of AudioPlayers and not of
// FlameAudio, later on, it would be good to use the FlameAudio method to
// avoid creating an AudioPlayer.
class AudioInstance {
  AudioInstance(this.file, this.audioCache, {this.isLoop = false});

  final String file;
  final AudioCache audioCache;
  final bool isLoop;

  late AudioPlayer _audioPlayer;

  AudioPlayer get audioPlayer => _audioPlayer;

  Future<AudioInstance> initialize() async {
    try {
      final AudioPlayer player = AudioPlayer(playerId: file);
      player.audioCache = audioCache;

      await player.setReleaseMode(
        isLoop ? ReleaseMode.loop : ReleaseMode.release,
      );

      _audioPlayer = player;

      return this;
    } catch (error) {
      throw Exception('Error initializing the audio instance: $error');
    }
  }

  void play() {
    try {
      _audioPlayer.play(AssetSource(file));
    } catch (error) {
      throw Exception('Error playing the audio: $error');
    }
  }

  void stop() {
    try {
      _audioPlayer.stop();
    } catch (error) {
      throw Exception('Error stoping the audio: $error');
    }
  }

  void dispose() {
    try {
      _audioPlayer.dispose();
    } catch (error) {
      throw Exception('Error disposing the audio: $error');
    }
  }
}

class AudioController {
  static late AudioCache audioLoopsCache;

  static late AudioInstance playerRunningAudio;

  static Future<void> _cacheAllFiles() async {
    try {
      await FlameAudio.audioCache.loadAll(<String>[kAudioAmbianceFile]);
      audioLoopsCache = AudioCache(prefix: kAudioLoopsPath);
    } catch (error) {
      throw Exception('Error caching the audio files: $error');
    }
  }

  static Future<void> _changeLogLevel({bool debug = false}) async {
    try {
      await AudioPlayer.global
          .changeLogLevel(debug ? LogLevel.info : LogLevel.error);
    } catch (error) {
      throw Exception('Error changing the log level: $error');
    }
  }

  static void _initializeBackgroundMusic() {
    try {
      FlameAudio.bgm.initialize();
    } catch (error) {
      throw Exception('Error initializing the background music: $error');
    }
  }

  static Future<void> _initializeAudioInstances() async {
    try {
      playerRunningAudio = await AudioInstance(
        kAudioRunningLoopFile,
        audioLoopsCache,
        isLoop: true,
      ).initialize();
    } catch (error) {
      throw Exception('Error initializing the audio instances: $error');
    }
  }

  static Future<void> initialize() async {
    try {
      await _cacheAllFiles();
      await _changeLogLevel(debug: dotenv.env['FLUTTER_ENV'] == 'dev');
      _initializeBackgroundMusic();
      await _initializeAudioInstances();
    } catch (error) {
      throw Exception('Error initializing the audio controller: $error');
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
  static Future<AudioPool> createPool(
    String filename, {
    int maxPlayers = kMaxNumberOfPlayers,
  }) async {
    try {
      return AudioPool.create(
        filename,
        maxPlayers: maxPlayers,
      );
    } catch (error) {
      throw Exception('Error creating the audio pool: $error');
    }
  }
}
