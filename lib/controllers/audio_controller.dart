import 'package:flame_audio/flame_audio.dart';

class AudioController {
  Future<void> cacheAllAudioFiles() async {
    await FlameAudio.audioCache.loadAll(
      <String>[
        'ambiance.wav',
        'fire.wav',
        'footsteps.wav',
        'pick-up.wav',
        'refill.wav'
      ],
    );
  }

  void initializeBackgroundMusic() {
    FlameAudio.bgm.initialize();
  }

  void playBackgroundMusic() {
    FlameAudio.bgm.play('ambiance.wav');
  }

  void playFire() {
    FlameAudio.play('fire.wav');
  }

  void playRefill() {
    FlameAudio.play('refill.wav');
  }

  void playPickUp() {
    FlameAudio.play('pick-up.wav');
  }
}
