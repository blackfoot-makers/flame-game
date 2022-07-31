import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';

class AudioController {
  Future<void> cacheAllFiles() async {
    await FlameAudio.audioCache.loadAll(<String>['ambiance.wav', 'run.wav']);
  }

  void initializeBackgroundMusic() {
    FlameAudio.bgm.initialize();
  }

  void playBackgroundMusic(String file, {double volume = 1.0}) {
    FlameAudio.bgm.play(file, volume: volume);
  }

  void disposeBackgroundMusic() {
    FlameAudio.bgm.dispose();
  }

  // https://docs.flame-engine.org/main/flame_audio/audio_pool.html
  Future<AudioPool> createPool(String filename) async {
    return AudioPool.create(
      filename,
      maxPlayers: 1,
    );
  }

  Future<AudioPlayer> play(
    String file, {
    bool isLongAudio = false,
    double volume = 1.0,
  }) async {
    return isLongAudio
        ? await FlameAudio.playLongAudio(file, volume: volume)
        : await FlameAudio.play(file, volume: volume);
  }

  Future<AudioPlayer> loop(
    String file, {
    bool isLongAudio = false,
    double volume = 1.0,
  }) async {
    return isLongAudio
        ? await FlameAudio.loopLongAudio(file, volume: volume)
        : await FlameAudio.loop(file, volume: volume);
  }
}
