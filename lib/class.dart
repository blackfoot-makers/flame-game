import 'package:json_annotation/json_annotation.dart';

part 'class.g.dart';

void fireGun(Soldiers soldiers) {
  if (soldiers.weapon.currentAmmo != 0 && soldiers.carryBox == false) {
    soldiers.weapon.currentAmmo -= 1;
  }
}

void reload(Weapon weapon) {
  if (weapon.currentAmmo != weapon.clipCapacity) {
    weapon.currentAmmo = weapon.clipCapacity;
  }
}

void nullSkill(Game game) {}

@JsonSerializable()
class Box {
  Box({
    required this.strenghRequirement,
    required this.path,
  });
  factory Box.fromJson(Map<String, dynamic> json) => _$BoxFromJson(json);
  int strenghRequirement;
  String path;
}

@JsonSerializable()
class Weapon {
  Weapon({
    required this.accuracy,
    required this.clipCapacity,
    required this.damage,
    required this.sprite,
    required this.currentAmmo,
  });
  factory Weapon.fromJson(Map<String, dynamic> json) => _$WeaponFromJson(json);
  int clipCapacity;
  int currentAmmo;
  int damage;
  int accuracy;
  String sprite;
}

@JsonSerializable()
class Stats {
  Stats({
    required this.strenght,
    required this.accuracy,
    required this.armor,
    required this.hitPoint,
    required this.speed,
  });
  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);
  int strenght;
  int accuracy;
  int speed;
  int hitPoint;
  int armor;
}

@JsonSerializable()
class Soldiers {
  Soldiers({
    required this.stats,
    required this.sprite,
    required this.weapon,
    this.passiv = nullSkill,
    this.ammo = 0,
    this.carryBox = false,
  });
  factory Soldiers.fromJson(Map<String, dynamic> json) =>
      _$SoldiersFromJson(json);
  Stats stats;
  String sprite;
  Weapon weapon;
  bool carryBox;
  int ammo;
  @JsonKey(ignore: true)
  Function(Game game) passiv;
}

@JsonSerializable()
class Monster {
  Monster({
    required this.stats,
    required this.sprite,
    this.skill = nullSkill,
  });
  factory Monster.fromJson(Map<String, dynamic> json) =>
      _$MonsterFromJson(json);
  @JsonKey(ignore: true)
  final Function(Game game) skill;
  final Stats stats;
  final String sprite;
}

@JsonSerializable()
class Game {
  Game({
    required this.name,
  });
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  final String name;
}