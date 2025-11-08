// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompletionAdapter extends TypeAdapter<Completion> {
  @override
  final int typeId = 3;

  @override
  Completion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Completion(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      count: fields[2] as int,
      selectedOption: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Completion obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.count)
      ..writeByte(3)
      ..write(obj.selectedOption);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompletionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
