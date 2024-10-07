class Gallery {
  String? edition;
  List<String>? image;
  int? timestamp;
  String? sk;
  String? pk;
  String? id;
  String? name;

  Gallery({
    this.edition,
    this.image,
    this.timestamp,
    this.sk,
    this.pk,
    this.id,
    this.name,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      edition: json['edition'],
      image: json['image'] != null ? List<String>.from(json['image']) : null,
      timestamp: json['timestamp'],
      sk: json['sk'],
      pk: json['pk'],
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'edition': edition,
      'image': image,
      'timestamp': timestamp,
      'sk': sk,
      'pk': pk,
      'id': id,
      'name': name,
    };
  }



  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Gallery &&
        other.edition == edition &&
        other.image == image &&
        other.timestamp == timestamp &&
        other.sk == sk &&
        other.pk == pk &&
        other.id == id &&
        other.name == name;
  }

  @override
  int get hashCode {
    return edition.hashCode ^
    image.hashCode ^
    timestamp.hashCode ^
    sk.hashCode ^
    pk.hashCode ^
    id.hashCode ^
    name.hashCode;
  }

  @override
  String toString() {
    return 'Gallery(edition: $edition, image: $image, timestamp: $timestamp, sk: $sk, pk: $pk, id: $id, name: $name)';
  }
}
