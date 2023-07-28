// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Sponsor {
  String? value;
  String? label;
  Sponsor({
    this.value,
    this.label,
  });

  Sponsor copyWith({
    String? value,
    String? label,
  }) {
    return Sponsor(
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'label': label,
    };
  }

  factory Sponsor.fromMap(Map<String, dynamic> map) {
    return Sponsor(
      value: map['value'] != null ? map['value'] as String : null,
      label: map['label'] != null ? map['label'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sponsor.fromJson(String source) =>
      Sponsor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Sponsor(value: $value, label: $label)';

  @override
  bool operator ==(covariant Sponsor other) {
    if (identical(this, other)) return true;

    return other.value == value && other.label == label;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode;
}
