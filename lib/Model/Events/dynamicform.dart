// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Dynamicform {
  String? label;
  String? placeholder;
  String? type;
  bool? required;
  String? options;
  Dynamicform({
    this.label,
    this.placeholder,
    this.type,
    this.required,
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
      label: map['label'] != null ? map['label'] as String : null,
      placeholder: map['placeholder'] != null ? map['placeholder'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      required: map['required'] != null ? map['required'] as bool : null,
      options: map['options'] != null ? map['options'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dynamicform.fromJson(String source) => Dynamicform.fromMap(json.decode(source) as Map<String, dynamic>);

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
