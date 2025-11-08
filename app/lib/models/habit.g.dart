// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 0;

  @override
  Habit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habit(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      icon: fields[3] as String,
      color: fields[4] as String,
      createdAt: fields[5] as DateTime,
      completions: (fields[6] as List?)?.cast<Completion>(),
      hasOrOptions: fields[7] as bool,
      orOptions: fields[8] as OrOptions?,
      tags: (fields[9] as List?)?.cast<String>(),
      isArchived: fields[10] as bool,
      streakGoal: fields[11] as int?,
      targetCompletionsPerDay: fields[12] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.completions)
      ..writeByte(7)
      ..write(obj.hasOrOptions)
      ..writeByte(8)
      ..write(obj.orOptions)
      ..writeByte(9)
      ..write(obj.tags)
      ..writeByte(10)
      ..write(obj.isArchived)
      ..writeByte(11)
      ..write(obj.streakGoal)
      ..writeByte(12)
      ..write(obj.targetCompletionsPerDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
