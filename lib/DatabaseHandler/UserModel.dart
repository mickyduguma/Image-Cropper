// ignore_for_file: file_names

class UserModel {
  String user_id ='user_id';
  String columnname='columnname';

  UserModel(this.user_id, this.columnname, );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'columnname': columnname,

    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    columnname = map['columnname'];

  }
}