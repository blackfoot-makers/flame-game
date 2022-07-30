import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';

class AudioController {
  static AudioCache audioCache = AudioCache(prefix: 'assets/audio');

  Future<void> cacheAllFiles() async {
    await audioCache.loadAll(<String>['ambiance.wav', 'run.wav']);
  }

  void initializeBackgroundMusic() {
    FlameAudio.bgm.initialize();
  }

  void disposeBackgroundMusic() {
    FlameAudio.bgm.dispose();
  }

  // Audio pools is reccomended for sfx like lazers, shots, etc.
  Future<AudioPool> createPool(String filename) async {
    return AudioPool.create(
      'audio/$filename',
      audioCache: audioCache,
      maxPlayers: 1, // TODO(alex): Get the number of players
    );
  }

  void play(
    String file, {
    bool isBackgroundMusic = false,
    bool isLongAudio = false,
    double volume = 1.0,
  }) {
    if (isBackgroundMusic) {
      FlameAudio.bgm.play(file, volume: volume);
    } else if (isLongAudio) {
      FlameAudio.playLongAudio(file, volume: volume);
    } else {
      FlameAudio.play(file, volume: volume);
    }
  }

  void loop(
    String file,
    bool isPlaying, {
    bool isLongAudio = false,
    double volume = 1.0,
  }) {
    if (isLongAudio && isPlaying) {
      FlameAudio.loopLongAudio(file, volume: volume);
    } else {
      FlameAudio.loop(file, volume: volume);
    }
  }
}
