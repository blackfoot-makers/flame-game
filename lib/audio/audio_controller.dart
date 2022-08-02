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
  AudioInstance(
    this.file, {
    required this.audioCache,
    this.releaseMode = ReleaseMode.loop,
    this.volume = 1.0,
  });

  final String file;
  final AudioCache audioCache;
  final ReleaseMode releaseMode;
  final double volume;

  late AudioPlayer _audioPlayer;

  AudioPlayer get audioPlayer => _audioPlayer;

  Future<AudioInstance> initialize() async {
    try {
      final AudioPlayer player = AudioPlayer(playerId: file);
      player.audioCache = audioCache;
      await player.setVolume(volume);
      await player.setReleaseMode(releaseMode);
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
  static late AudioCache loopsAudioCache;
  static late AudioCache sfxAudioCache;

  static late AudioInstance playerRunningAudioInstance;

  static late AudioPool playerGunshotAudioPool;

  static Future<void> _cacheAllFiles() async {
    try {
      await FlameAudio.audioCache.load(kAudioAmbianceFile);
      loopsAudioCache = AudioCache(prefix: kAudioLoopsPath);
      sfxAudioCache = AudioCache(prefix: kAudioSFXPath);
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

  // The AudioInstance is functional for looping type, like a walking loop.
  static Future<void> _initializeAudioInstances() async {
    try {
      playerRunningAudioInstance = await AudioInstance(
        kAudioRunningLoopFile,
        audioCache: loopsAudioCache,
        volume: 2.0,
      ).initialize();
    } catch (error) {
      throw Exception('Error initializing the audio instances: $error');
    }
  }

  // The AudioPool is convenient and functional for sfx type sounds, like a
  // gunshot. https://docs.flame-engine.org/main/flame_audio/audio_pool.html
  static Future<void> _initializeAudioPools() async {
    try {
      playerGunshotAudioPool = await AudioPool.create(
        kAudioGunshotSFXFile,
        audioCache: sfxAudioCache,
        maxPlayers: kMaxNumberOfPlayers,
      );
    } catch (error) {
      throw Exception('Error initializing the audio pools: $error');
    }
  }

  static Future<void> initialize() async {
    try {
      await _cacheAllFiles();
      await _changeLogLevel(debug: dotenv.env['FLUTTER_ENV'] == 'dev');
      _initializeBackgroundMusic();
      await _initializeAudioInstances();
      await _initializeAudioPools();
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
}
