// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculation_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalculationItemAdapter extends TypeAdapter<CalculationItem> {
  @override
  final int typeId = 0;

  @override
  CalculationItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalculationItem(
      type: fields[0] as String?,
      date: fields[1] as String?,
      remark: fields[2] as String?,
      totalAmount: fields[3] as String?,
      calculation: (fields[4] as List?)?.cast<Calculation>(),
    );
  }

  @override
  void write(BinaryWriter writer, CalculationItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.remark)
      ..writeByte(3)
      ..write(obj.totalAmount)
      ..writeByte(4)
      ..write(obj.calculation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculationItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CalculationAdapter extends TypeAdapter<Calculation> {
  @override
  final int typeId = 1;

  @override
  Calculation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Calculation(
      multiplier: fields[0] as String?,
      multiplicand: fields[1] as String?,
      product: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Calculation obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.multiplier)
      ..writeByte(1)
      ..write(obj.multiplicand)
      ..writeByte(2)
      ..write(obj.product);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
