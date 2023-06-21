import 'dart:convert';

class Reqdfield {
  final String value;
  final String label;
  Reqdfield({
    required this.value,
    required this.label,
  });

  Reqdfield copyWith({
    String? value,
    String? label,
  }) {
    return Reqdfield(
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

  factory Reqdfield.fromMap(Map<String, dynamic> map) {
    return Reqdfield(
      value: map['value'] as String,
      label: map['label'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Reqdfield.fromJson(String source) => Reqdfield.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Reqdfield(value: $value, label: $label)';

  @override
  bool operator ==(covariant Reqdfield other) {
    if (identical(this, other)) return true;
  
    return 
      other.value == value &&
      other.label == label;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode;
}