class UserModel {
  final String? id;
  final String username;
  final String email;
  
  

  UserModel({required this.email, required this.username, this.id});

  UserModel copyWith({
    String? id,
    required String username,
    required String email,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username, 
      email: email, 
    );
  }
  
}