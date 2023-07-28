// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Dynamicform {
  final String label;
  final String placeholder;
  final String type;
  final bool required;
  String? options;
  Dynamicform({
    required this.label,
    required this.placeholder,
    required this.type,
    required this.required,
    this.options,
  });

  Dynamicform copyWith({
    String? label,
    String? placeholder,
    String? type,
    bool? required,
    String? options,
  }) {
    return Dynamicform(
      label: label ?? this.label,
      placeholder: placeholder ?? this.placeholder,
      type: type ?? this.type,
      required: required ?? this.required,
      options: options ?? this.options,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'placeholder': placeholder,
      'type': type,
      'required': required,
      'options': options,
    };
  }

  factory Dynamicform.fromMap(Map<String, dynamic> map) {
    return Dynamicform(
      label: map['label'] as String,
      placeholder: map['placeholder'] as String,
      type: map['type'] as String,
      required: map['required'] as bool,
      options: map['options'] != null ? map['options'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dynamicform.fromJson(String source) =>
      Dynamicform.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Dynamicform(label: $label, placeholder: $placeholder, type: $type, required: $required, options: $options)';
  }

  @override
  bool operator ==(covariant Dynamicform other) {
    if (identical(this, other)) return true;
  
    return 
      other.label == label &&
      other.placeholder == placeholder &&
      other.type == type &&
      other.required == required &&
      other.options == options;
  }

  @override
  int get hashCode {
    return label.hashCode ^
      placeholder.hashCode ^
      type.hashCode ^
      required.hashCode ^
      options.hashCode;
  }
}
