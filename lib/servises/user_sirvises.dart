class MyUser{
  String? id;
  String? name;
  String? avatarUrl;
  String? email;

  MyUser({ this.id,  this.email,  this.name, this.avatarUrl });

  factory MyUser.fromMap(map){
    return MyUser( email: map['email'], name: map['name']);
  }
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
}