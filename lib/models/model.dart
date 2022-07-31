import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Box {
  Box({
    required this.strenghRequirement,
    required this.spritePath,
  });
  factory Box.fromJson(Map<String, dynamic> json) => _$BoxFromJson(json);
  Map<String, dynamic> toJson() => _$BoxToJson(this);

  int strenghRequirement;
  String spritePath;
}

@JsonSerializable()
class Weapon {
  Weapon({
    required this.accuracy,
    required this.clipCapacity,
    required this.damage,
    required this.spritePath,
    required this.currentAmmo,
  });
  factory Weapon.fromJson(Map<String, dynamic> json) => _$WeaponFromJson(json);
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

  Map<String, dynamic> toJson() => _$WeaponToJson(this);
  int clipCapacity;
  int currentAmmo;
  int damage;
  int accuracy;
  String spritePath;
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
  Map<String, dynamic> toJson() => _$StatsToJson(this);

  int strenght;
  int accuracy;
  int speed;
  int hitPoint;
  int armor;
}

@JsonSerializable()
class Character {
  Character({
    required this.stats,
    required this.spritePath,
    required this.uuid,
  });
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  String uuid;
  Stats stats;
  String spritePath;
}

@JsonSerializable()
class Soldiers extends Character {
  Soldiers({
    required super.stats,
    required super.spritePath,
    required this.weapon,
    this.passive,
    this.ammo = 0,
    this.carryBox = false,
    required super.uuid,
  });
  factory Soldiers.fromJson(Map<String, dynamic> json) =>
      _$SoldiersFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SoldiersToJson(this);

  Weapon weapon;
  bool carryBox;
  int ammo;
  @JsonKey(ignore: true)
  Function(Game game)? passive;
}

@JsonSerializable()
class Monster extends Character {
  Monster({
    required super.spritePath,
    required super.stats,
    required super.uuid,
    this.skill,
  });
  factory Monster.fromJson(Map<String, dynamic> json) =>
      _$MonsterFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MonsterToJson(this);
  @JsonKey(ignore: true)
  final Function(Game game)? skill;
}

@JsonSerializable()
class Game {
  Game({
    required this.name,
  });
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);

  final String name;
}
