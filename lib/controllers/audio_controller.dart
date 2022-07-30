import 'package:flame_audio/flame_audio.dart';

class Audio {}

class AudioController {
  Future<void> cacheAllAudioFiles() async {
    await FlameAudio.audioCache.loadAll(
      <String>[
        'ambiance.wav',
        'fire.wav',
        'pick_up_1.wav',
        'pick_up_2.wav',
        'refill.wav',
        'run.wav',
        'walk.wav'
      ],
    );
  }

  void initializeBackgroundMusic() {
    FlameAudio.bgm.initialize();
  }

  void disposeBackgroundMusic() {
    FlameAudio.bgm.dispose();
  }

  void stopBackgroundMusic() {
    FlameAudio.bgm.stop();
  }

  void playBackgroundMusic() {
    FlameAudio.bgm.play('ambiance.wav', volume: 0.25);
  }

  void playFire() {
    FlameAudio.play('fire.wav');
  }

  void playRefill() {
    FlameAudio.play('refill.wav');
  }

  void playPickUp(int pickupIndex) {
    FlameAudio.play('pick_up_$pickupIndex.wav');
  }

  void loopIsWalking() {
    FlameAudio.play('walk.wav');
  }

  void loopIsRunning(bool isRunning) {
    if (isRunning) {
      FlameAudio.loop('run.wav');
    }
  }
}
