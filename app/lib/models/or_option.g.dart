// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'or_option.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrOptionAdapter extends TypeAdapter<OrOption> {
  @override
  final int typeId = 1;

  @override
  OrOption read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrOption(
      name: fields[0] as String,
      color: fields[1] as String,
      icon: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OrOption obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.color)
      ..writeByte(2)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrOptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrOptionsAdapter extends TypeAdapter<OrOptions> {
  @override
  final int typeId = 2;

  @override
  OrOptions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrOptions(
      option1: fields[0] as OrOption,
      option2: fields[1] as OrOption,
    );
  }

  @override
  void write(BinaryWriter writer, OrOptions obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.option1)
      ..writeByte(1)
      ..write(obj.option2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrOptionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
