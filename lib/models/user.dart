class User{
  final num number;
  final String name;
  final String password;
  final String email;
  User( this.number, this.name, this.password, this.email);

  Map<String, dynamic> toJson()=>{
    'number': number,
    'username': name,
    'password': password,
    'email': email,
  };
}