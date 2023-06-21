import 'package:el_zareef_app/models/student.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 0; // Make sure to assign a unique typeId for each TypeAdapter

  @override
  Student read(BinaryReader reader) {
    return Student(
      name: reader.readString(),
      gphone: reader.readInt(),
      sphone: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.gphone);
    writer.writeInt(obj.sphone);
  }
}
