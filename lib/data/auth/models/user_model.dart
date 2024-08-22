class UserModel {
  final String? id;
  final String? username;
  final String email;
  
  

  UserModel({required this.email,  this.username, this.id});

  UserModel copyWith({
    String? id,
    String? username,
    required String email,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username, 
      email: email, 
    );
  }
  
}