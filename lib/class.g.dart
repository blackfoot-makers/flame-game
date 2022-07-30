// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Box _$BoxFromJson(Map<String, dynamic> json) => Box(
      strenghRequirement: json['strenghRequirement'] as int,
      path: json['path'] as String,
    );

Map<String, dynamic> _$BoxToJson(Box instance) => <String, dynamic>{
      'strenghRequirement': instance.strenghRequirement,
      'path': instance.path,
    };

Weapon _$WeaponFromJson(Map<String, dynamic> json) => Weapon(
      accuracy: json['accuracy'] as int,
      clipCapacity: json['clipCapacity'] as int,
      damage: json['damage'] as int,
      sprite: json['sprite'] as String,
      currentAmmo: json['currentAmmo'] as int,
    );

Map<String, dynamic> _$WeaponToJson(Weapon instance) => <String, dynamic>{
      'clipCapacity': instance.clipCapacity,
      'currentAmmo': instance.currentAmmo,
      'damage': instance.damage,
      'accuracy': instance.accuracy,
      'sprite': instance.sprite,
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

Soldiers _$SoldiersFromJson(Map<String, dynamic> json) => Soldiers(
      stats: Stats.fromJson(json['stats'] as Map<String, dynamic>),
      sprite: json['sprite'] as String,
      weapon: Weapon.fromJson(json['weapon'] as Map<String, dynamic>),
      ammo: json['ammo'] as int? ?? 0,
      carryBox: json['carryBox'] as bool? ?? false,
    );

Map<String, dynamic> _$SoldiersToJson(Soldiers instance) => <String, dynamic>{
      'stats': instance.stats,
      'sprite': instance.sprite,
      'weapon': instance.weapon,
      'carryBox': instance.carryBox,
      'ammo': instance.ammo,
    };

Monster _$MonsterFromJson(Map<String, dynamic> json) => Monster(
      stats: Stats.fromJson(json['stats'] as Map<String, dynamic>),
      sprite: json['sprite'] as String,
    );

Map<String, dynamic> _$MonsterToJson(Monster instance) => <String, dynamic>{
      'stats': instance.stats,
      'sprite': instance.sprite,
    };

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      name: json['name'] as String,
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'name': instance.name,
    };
