import 'package:flame_audio/flame_audio.dart';

enum AudioController {
  ambiance(filename: 'ambiance.wav', bgm: true),
  fire(filename: 'fire.wav'),
  pickup(filename: 'pick_up_1.wav'),
  refill(filename: 'refill.wav'),
  run(filename: 'run.wav'),
  walk(filename: 'walk.wav');

  const AudioController({required this.filename, this.bgm = false});

  final String filename;
  final bool bgm;

  void play(double? volume) {
    if (bgm) {
      FlameAudio.bgm.play(filename, volume: volume ?? 1.0);
    } else {
      FlameAudio.play(filename, volume: volume ?? 1.0);
    }
  }

  void loop(double? volume) {
    FlameAudio.loop(filename, volume: volume ?? 1.0);
  }

  void disposeBgm() {
    FlameAudio.bgm.dispose();
  }
}
