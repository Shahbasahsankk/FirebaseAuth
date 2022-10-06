class StudentModel {
  String? uid;
  String? name;
  String? domain;
  String? age;
  String? number;

  StudentModel({
    required this.uid,
    required this.name,
    required this.domain,
    required this.age,
    required this.number,
  });
  // data from server
  factory StudentModel.fromMap(map) {
    return StudentModel(
      uid: map['uid'],
      name: map['name'],
      domain: map['domain'],
      age: map['age'],
      number: map['number'],
    );
  }
  // data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'domain': domain,
      'age': age,
      'number': number,
    };
  }
}
