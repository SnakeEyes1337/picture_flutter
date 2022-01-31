class MyUser{
  String? name;
  String? avatarUrl;
  String? email;

  MyUser({this.email,  this.name, this.avatarUrl="https://gotrening.com/wp-content/uploads/2021/04/user.png" });

  factory MyUser.fromMap(map){
    return MyUser( email: map['email'], name: map['name'], avatarUrl: map['avatarUrl']);
  }
  Map<String, dynamic> toMap(){
    return {
      'avatarUrl': avatarUrl,
      'email': email,
      'name': name,
    };
  }
}