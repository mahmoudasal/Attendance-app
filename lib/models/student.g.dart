import 'package:el_zareef_app/models/student.dart';
import 'package:hive/hive.dart';

class StudentAdapter extends TypeAdapter<Student> {
  @override
  int get typeId => 0;

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
