class UserModel {
  final String? id;
  final String? username;
  final String email;
  
  

  UserModel({required this.email,  this.username, this.id});

  factory UserModel.copyWith({
    String? id,
    String? username,
    required String email,
  }) {
    return UserModel(
      id: id,
      username: username , 
      email: email, 
    );
  }
  
}