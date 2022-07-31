// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Box _$BoxFromJson(Map<String, dynamic> json) => Box(
      strenghRequirement: json['strenghRequirement'] as int,
      spritePath: json['spritePath'] as String,
    );

Map<String, dynamic> _$BoxToJson(Box instance) => <String, dynamic>{
      'strenghRequirement': instance.strenghRequirement,
      'spritePath': instance.spritePath,
    };

Weapon _$WeaponFromJson(Map<String, dynamic> json) => Weapon(
      accuracy: json['accuracy'] as int,
      clipCapacity: json['clipCapacity'] as int,
      damage: json['damage'] as int,
      spritePath: json['spritePath'] as String,
      currentAmmo: json['currentAmmo'] as int,
    );

Map<String, dynamic> _$WeaponToJson(Weapon instance) => <String, dynamic>{
      'clipCapacity': instance.clipCapacity,
      'currentAmmo': instance.currentAmmo,
      'damage': instance.damage,
      'accuracy': instance.accuracy,
      'spritePath': instance.spritePath,
    };

Stats _$StatsFromJson(Map<String, dynamic> json) => Stats(
      strenght: json['strenght'] as int,
      accuracy: json['accuracy'] as int,
      armor: json['armor'] as int,
      hitPoint: json['hitPoint'] as int,
      speed: json['speed'] as int,
    );

Map<String, dynamic> _$StatsToJson(Stats instance) => <String, dynamic>{
      'strenght': instance.strenght,
      'accuracy': instance.accuracy,
      'speed': instance.speed,
      'hitPoint': instance.hitPoint,
      'armor': instance.armor,
    };

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      stats: Stats.fromJson(json['stats'] as Map<String, dynamic>),
      spritePath: json['spritePath'] as String,
      uuid: json['uuid'] as String,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'stats': instance.stats,
      'spritePath': instance.spritePath,
    };

Soldiers _$SoldiersFromJson(Map<String, dynamic> json) => Soldiers(
      stats: Stats.fromJson(json['stats'] as Map<String, dynamic>),
      spritePath: json['spritePath'] as String,
      weapon: Weapon.fromJson(json['weapon'] as Map<String, dynamic>),
      ammo: json['ammo'] as int? ?? 0,
      carryBox: json['carryBox'] as bool? ?? false,
      uuid: json['uuid'] as String,
    );

Map<String, dynamic> _$SoldiersToJson(Soldiers instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'stats': instance.stats,
      'spritePath': instance.spritePath,
      'weapon': instance.weapon,
      'carryBox': instance.carryBox,
      'ammo': instance.ammo,
    };

Monster _$MonsterFromJson(Map<String, dynamic> json) => Monster(
      spritePath: json['spritePath'] as String,
      stats: Stats.fromJson(json['stats'] as Map<String, dynamic>),
      uuid: json['uuid'] as String,
    );

Map<String, dynamic> _$MonsterToJson(Monster instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'stats': instance.stats,
      'spritePath': instance.spritePath,
    };

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      name: json['name'] as String,
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'name': instance.name,
    };
