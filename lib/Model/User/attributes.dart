// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserAttributes {
  final String? name;
  final String? email;
  final String? image;
  UserAttributes({
    this.name,
    this.email,
    this.image,
  });

  UserAttributes copyWith({
    String? name,
    String? email,
    String? image,
  }) {
    return UserAttributes(
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'image': image,
    };
  }

  factory UserAttributes.fromMap(Map<String, dynamic> map) {
    return UserAttributes(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAttributes.fromJson(String source) => UserAttributes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserAttributes(name: $name, email: $email, image: $image)';

  @override
  bool operator ==(covariant UserAttributes other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.image == image;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ image.hashCode;
}
