void fireGun(Weapon weapon) {
  if (weapon.currentAmmo != 0) {
    weapon.currentAmmo -= 1;
  }
}

void reload(Weapon weapon) {
  if (weapon.currentAmmo != weapon.clipCapacity) {
    weapon.clipCapacity = weapon.clipCapacity;
  }
}

class Weapon {
  Weapon({
    this.accuracy,
    this.clipCapacity,
    this.damage,
    required this.sprite,
    required this.currentAmmo,
  });
  int? clipCapacity;
  int currentAmmo;
  int? damage;
  int? accuracy;
  String? sprite;
}

class Stats {
  Stats({
    this.strenght,
    this.accuracy,
    this.armor,
    this.hitPoint,
    this.speed,
  });

  int? strenght;
  int? accuracy;
  int? speed;
  int? hitPoint;
  int? armor;
}

class Soldiers {
  Soldiers({
    required this.stats,
    required this.sprite,
    this.weapon,
    required this.passiv,
    this.ammo,
  });
  Stats? stats;
  String? sprite;
  Weapon? weapon;
  int? ammo;
  final Function passiv;
}

class Monsters {
  Monsters({
    required this.stats,
    required this.sprite,
    required this.capacity,
  });
  final Function capacity;
  final Stats stats;
  final String sprite;
}
