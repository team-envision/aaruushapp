// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:aarush/Model/Events/reqdfield.dart';

//Dont forget to change int to dynamic for reqdfield
class EventListModel {
  String? oneliner;
  String? startdate;
  String? time;
  String? name;
  String? date;
  String? image;
  String? about;
  String? sk;
  String? id;
  List<dynamic>? gallery;
  String? headerImage;
  String? location;
  String? mode;
  String? contact;
  int? timestamp;
  bool? live;
  String? payment_type;
  List<Reqdfield>? reqdfields;
  String? structure;
  String? faq;
  int? updatedAt;
  String? category;
  String? pk;
  String? timeline;
  String? reglink;
  EventListModel({
    this.oneliner,
    this.startdate,
    this.time,
    this.name,
    this.date,
    this.image,
    this.about,
    this.sk,
    this.id,
    this.gallery,
    this.headerImage,
    this.location,
    this.mode,
    this.contact,
    this.timestamp,
    this.live,
    this.payment_type,
    this.reqdfields,
    this.structure,
    this.faq,
    this.updatedAt,
    this.category,
    this.pk,
    this.timeline,
    this.reglink,
  });

  EventListModel copyWith({
    String? oneliner,
    String? startdate,
    String? time,
    String? name,
    String? date,
    String? image,
    String? about,
    String? sk,
    String? id,
    List<dynamic>? gallery,
    String? headerImage,
    String? location,
    String? mode,
    String? contact,
    int? timestamp,
    bool? live,
    String? payment_type,
    List<Reqdfield>? reqdfields,
    String? structure,
    String? faq,
    int? updatedAt,
    String? category,
    String? pk,
    String? timeline,
    String? reglink,
  }) {
    return EventListModel(
      oneliner: oneliner ?? this.oneliner,
      startdate: startdate ?? this.startdate,
      time: time ?? this.time,
      name: name ?? this.name,
      date: date ?? this.date,
      image: image ?? this.image,
      about: about ?? this.about,
      sk: sk ?? this.sk,
      id: id ?? this.id,
      gallery: gallery ?? this.gallery,
      headerImage: headerImage ?? this.headerImage,
      location: location ?? this.location,
      mode: mode ?? this.mode,
      contact: contact ?? this.contact,
      timestamp: timestamp ?? this.timestamp,
      live: live ?? this.live,
      payment_type: payment_type ?? this.payment_type,
      reqdfields: reqdfields ?? this.reqdfields,
      structure: structure ?? this.structure,
      faq: faq ?? this.faq,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      pk: pk ?? this.pk,
      timeline: timeline ?? this.timeline,
      reglink: reglink ?? this.reglink,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'oneliner': oneliner,
      'startdate': startdate,
      'time': time,
      'name': name,
      'date': date,
      'image': image,
      'about': about,
      'sk': sk,
      'id': id,
      'gallery': gallery,
      'headerImage': headerImage,
      'location': location,
      'mode': mode,
      'contact': contact,
      'timestamp': timestamp,
      'live': live,
      'payment_type': payment_type,
      'reqdfields': reqdfields?.map((x) => x.toMap()).toList(),
      'structure': structure,
      'faq': faq,
      'updatedAt': updatedAt,
      'category': category,
      'pk': pk,
      'timeline': timeline,
      'reglink': reglink,
    };
  }

  factory EventListModel.fromMap(Map<String, dynamic> map) {
    return EventListModel(
      oneliner: map['oneliner'] != null ? map['oneliner'] as String : null,
      startdate: map['startdate'] != null ? map['startdate'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      about: map['about'] != null ? map['about'] as String : null,
      sk: map['sk'] != null ? map['sk'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      gallery: map['gallery'] != null
          ? List<dynamic>.from((map['gallery'] as List<dynamic>))
          : null,
      headerImage:
          map['headerImage'] != null ? map['headerImage'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      mode: map['mode'] != null ? map['mode'] as String : null,
      contact: map['contact'] != null ? map['contact'] as String : null,
      timestamp: map['timestamp'] != null ? map['timestamp'] as int : null,
      live: map['live'] != null ? map['live'] as bool : null,
      payment_type:
          map['payment_type'] != null ? map['payment_type'] as String : null,
      reqdfields: map['reqdfields'] != null
          ? List<Reqdfield>.from(
              (map['reqdfields'] as List<dynamic>).map<Reqdfield?>(
                (x) => Reqdfield.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      structure: map['structure'] != null ? map['structure'] as String : null,
      faq: map['faq'] != null ? map['faq'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as int : null,
      category: map['category'] != null ? map['category'] as String : null,
      pk: map['pk'] != null ? map['pk'] as String : null,
      timeline: map['timeline'] != null ? map['timeline'] as String : null,
      reglink: map['reglink'] != null ? map['reglink'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventListModel.fromJson(String source) =>
      EventListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EventListModel(oneliner: $oneliner, startdate: $startdate, time: $time, name: $name, date: $date, image: $image, about: $about, sk: $sk, id: $id, gallery: $gallery, headerImage: $headerImage, location: $location, mode: $mode, contact: $contact, timestamp: $timestamp, live: $live, payment_type: $payment_type, reqdfields: $reqdfields, structure: $structure, faq: $faq, updatedAt: $updatedAt, category: $category, pk: $pk, timeline: $timeline, reglink: $reglink)';
  }

  @override
  bool operator ==(covariant EventListModel other) {
    if (identical(this, other)) return true;

    return other.oneliner == oneliner &&
        other.startdate == startdate &&
        other.time == time &&
        other.name == name &&
        other.date == date &&
        other.image == image &&
        other.about == about &&
        other.sk == sk &&
        other.id == id &&
        listEquals(other.gallery, gallery) &&
        other.headerImage == headerImage &&
        other.location == location &&
        other.mode == mode &&
        other.contact == contact &&
        other.timestamp == timestamp &&
        other.live == live &&
        other.payment_type == payment_type &&
        listEquals(other.reqdfields, reqdfields) &&
        other.structure == structure &&
        other.faq == faq &&
        other.updatedAt == updatedAt &&
        other.category == category &&
        other.pk == pk &&
        other.timeline == timeline &&
        other.reglink == reglink;
  }

  @override
  int get hashCode {
    return oneliner.hashCode ^
        startdate.hashCode ^
        time.hashCode ^
        name.hashCode ^
        date.hashCode ^
        image.hashCode ^
        about.hashCode ^
        sk.hashCode ^
        id.hashCode ^
        gallery.hashCode ^
        headerImage.hashCode ^
        location.hashCode ^
        mode.hashCode ^
        contact.hashCode ^
        timestamp.hashCode ^
        live.hashCode ^
        payment_type.hashCode ^
        reqdfields.hashCode ^
        structure.hashCode ^
        faq.hashCode ^
        updatedAt.hashCode ^
        category.hashCode ^
        pk.hashCode ^
        timeline.hashCode ^
        reglink.hashCode;
  }
}
