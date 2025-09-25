// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class AudioRecordingModelAdapter extends TypeAdapter<AudioRecordingModel> {
  @override
  final typeId = 0;

  @override
  AudioRecordingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AudioRecordingModel(
      id: fields[8] as String,
      name: fields[0] as String,
      filePath: fields[2] as String,
      mood: fields[4] as Mood,
      tags: (fields[5] as List).cast<RecordingTagModel>(),
      isFavourite: fields[3] as bool,
      createdAt: fields[6] as DateTime,
      updatedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AudioRecordingModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.filePath)
      ..writeByte(3)
      ..write(obj.isFavourite)
      ..writeByte(4)
      ..write(obj.mood)
      ..writeByte(5)
      ..write(obj.tags)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioRecordingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecordingTagModelAdapter extends TypeAdapter<RecordingTagModel> {
  @override
  final typeId = 1;

  @override
  RecordingTagModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecordingTagModel(
      id: fields[0] as String,
      label: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RecordingTagModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordingTagModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MoodAdapter extends TypeAdapter<Mood> {
  @override
  final typeId = 2;

  @override
  Mood read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Mood.happy;
      case 1:
        return Mood.angry;
      case 2:
        return Mood.confused;
      case 10:
        return Mood.sad;
      case 11:
        return Mood.shock;
      case 12:
        return Mood.flirty;
      case 13:
        return Mood.calm;
      case 14:
        return Mood.playful;
      case 15:
        return Mood.smooch;
      case 16:
        return Mood.tired;
      default:
        return Mood.happy;
    }
  }

  @override
  void write(BinaryWriter writer, Mood obj) {
    switch (obj) {
      case Mood.happy:
        writer.writeByte(0);
      case Mood.angry:
        writer.writeByte(1);
      case Mood.confused:
        writer.writeByte(2);
      case Mood.sad:
        writer.writeByte(10);
      case Mood.shock:
        writer.writeByte(11);
      case Mood.flirty:
        writer.writeByte(12);
      case Mood.calm:
        writer.writeByte(13);
      case Mood.playful:
        writer.writeByte(14);
      case Mood.smooch:
        writer.writeByte(15);
      case Mood.tired:
        writer.writeByte(16);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
