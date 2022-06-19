class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? dob;

  UserModel({this.uid, this.email, this.firstName, this.lastName, this.dob});

  //data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        dob: map['dob']);
  }

//sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob,
    };
  }
}
