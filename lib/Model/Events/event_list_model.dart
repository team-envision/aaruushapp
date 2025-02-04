// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:AARUUSH_CONNECT/Model/Events/sponsor.dart';

import 'dynamicform.dart';

class EventListModel {
  String? headerImage;
  String? edition;
  String? location;
  String? mode;
  String? pricepool;
  int? timestamp;
  String? oneliner;
  String? startdate;
  String? locationLng;
  String? locationLat;
  List<Sponsor>? sponsors;
  String? time;
  List<Dynamicform>? dynamicform;
  String? name;
  bool? live;
  String? payment_type;
  String? date;
  bool? reqdfields;
  String? reglink;
  String? structure;
  String? image;
  String? about;
  String? category;
  String? sk;
  String? pk;
  String? id;
  String? sortCategory;
  String? timeline;
  List<dynamic>? gallery;
  String? contact;
  EventListModel({
    this.headerImage,
    this.location,
    this.mode,
    this.pricepool,
    this.timestamp,
    this.oneliner,
    this.startdate,
    this.locationLng,
    this.locationLat,
    this.sponsors,
    this.time,
    this.dynamicform,
    this.name,
    this.live,
    this.edition,
    this.payment_type,
    this.date,
    this.reqdfields,
    this.reglink,
    this.structure,
    this.image,
    this.about,
    this.category,
    this.sk,
    this.pk,
    this.id,
    this.sortCategory,
    this.timeline,
    this.gallery,
    this.contact,
  });

  EventListModel copyWith({
    String? edition,
    String? headerImage,
    String? location,
    String? mode,
    String? pricepool,
    int? timestamp,
    String? oneliner,
    String? startdate,
    String? locationLng,
    String? locationLat,
    List<Sponsor>? sponsors,
    String? time,
    List<Dynamicform>? dynamicform,
    String? name,
    bool? live,
    String? payment_type,
    String? date,
    bool? reqdfields,
    String? reglink,
    String? structure,
    String? image,
    String? about,
    String? category,
    String? sk,
    String? pk,
    String? id,
    String? sortCategory,
    String? timeline,
    List<dynamic>? gallery,
    String? contact,
  }) {
    return EventListModel(
      edition: edition ?? this.edition,
      headerImage: headerImage ?? this.headerImage,
      location: location ?? this.location,
      mode: mode ?? this.mode,
      pricepool: pricepool ?? this.pricepool,
      timestamp: timestamp ?? this.timestamp,
      oneliner: oneliner ?? this.oneliner,
      startdate: startdate ?? this.startdate,
      locationLng: locationLng ?? this.locationLng,
      locationLat: locationLat ?? this.locationLat,
      sponsors: sponsors ?? this.sponsors,
      time: time ?? this.time,
      dynamicform: dynamicform ?? this.dynamicform,
      name: name ?? this.name,
      live: live ?? this.live,
      payment_type: payment_type ?? this.payment_type,
      date: date ?? this.date,
      reqdfields: reqdfields ?? this.reqdfields,
      reglink: reglink ?? this.reglink,
      structure: structure ?? this.structure,
      image: image ?? this.image,
      about: about ?? this.about,
      category: category ?? this.category,
      sk: sk ?? this.sk,
      pk: pk ?? this.pk,
      id: id ?? this.id,
      sortCategory: sortCategory ?? this.sortCategory,
      timeline: timeline ?? this.timeline,
      gallery: gallery ?? this.gallery,
      contact: contact ?? this.contact,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'headerImage': headerImage,
      'location': location,
      'mode': mode,
      'edition': edition,
      'pricepool': pricepool,
      'timestamp': timestamp,
      'oneliner': oneliner,
      'startdate': startdate,
      'locationLng': locationLng,
      'locationLat': locationLat,
      'sponsors': sponsors?.map((x) => x?.toMap()).toList(),
      'time': time,
      'dynamicform': dynamicform?.map((x) => x?.toMap()).toList(),
      'name': name,
      'live': live,
      'payment_type': payment_type,
      'date': date,
      'reqdfields': reqdfields,
      'reglink': reglink,
      'structure': structure,
      'image': image,
      'about': about,
      'category': category,
      'sk': sk,
      'pk': pk,
      'id': id,
      'sortCategory': sortCategory,
      'timeline': timeline,
      'gallery': gallery,
      'contact': contact,
    };
  }

  factory EventListModel.fromMap(Map<String, dynamic> map) {
    return EventListModel(
      edition: map['edition'] != null ? map['edition'] as String : null,
      headerImage:
          map['headerImage'] != null ? map['headerImage'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      mode: map['mode'] != null ? map['mode'] as String : null,
      pricepool: map['pricepool'] != null ? map['pricepool'] as String : null,
      timestamp: map['timestamp'] != null ? map['timestamp'] as int : null,
      oneliner: map['oneliner'] != null ? map['oneliner'] as String : null,
      startdate: map['startdate'] != null ? map['startdate'] as String : null,
      locationLng:
          map['locationLng'] != null ? map['locationLng'] as String : null,
      locationLat:
          map['locationLat'] != null ? map['locationLat'] as String : null,
      sponsors: map['sponsors'] != null
          ? List<Sponsor>.from(
              (map['sponsors'] as List<dynamic>).map<Sponsor?>(
                (x) => Sponsor.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      time: map['time'] != null ? map['time'] as String : null,
      dynamicform: map['dynamicform'] != null
          ? List<Dynamicform>.from(
              (map['dynamicform'] as List<dynamic>).map<Dynamicform?>(
                (x) => Dynamicform.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      live: map['live'] != null ? map['live'] as bool : null,
      payment_type:
          map['payment_type'] != null ? map['payment_type'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      reqdfields: map['reqdfields'] != null ? map['reqdfields'] as bool : null,
      reglink: map['reglink'] != null ? map['reglink'] as String : null,
      structure: map['structure'] != null ? map['structure'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      about: map['about'] != null ? map['about'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      sk: map['sk'] != null ? map['sk'] as String : null,
      pk: map['pk'] != null ? map['pk'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      sortCategory:
          map['sortCategory'] != null ? map['sortCategory'] as String : null,
      timeline: map['timeline'] != null ? map['timeline'] as String : null,
      gallery: map['gallery'] != null
          ? List<dynamic>.from((map['gallery'] as List<dynamic>))
          : null,
      contact: map['contact'] != null ? map['contact'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventListModel.fromJson(String source) =>
      EventListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EventListModel(headerImage: $headerImage, edition: $edition ,location: $location, mode: $mode, pricepool: $pricepool, timestamp: $timestamp, oneliner: $oneliner, startdate: $startdate, locationLng: $locationLng, locationLat: $locationLat, sponsors: $sponsors, time: $time, dynamicform: $dynamicform, name: $name, live: $live, payment_type: $payment_type, date: $date, reqdfields: $reqdfields, reglink: $reglink, structure: $structure, image: $image, about: $about, category: $category, sk: $sk, pk: $pk, id: $id, sortCategory: $sortCategory, timeline: $timeline, gallery: $gallery, contact: $contact)';
  }

  @override
  bool operator ==(covariant EventListModel other) {
    if (identical(this, other)) return true;

    return other.edition == edition &&
        other.headerImage == headerImage &&
        other.location == location &&
        other.mode == mode &&
        other.pricepool == pricepool &&
        other.timestamp == timestamp &&
        other.oneliner == oneliner &&
        other.startdate == startdate &&
        other.locationLng == locationLng &&
        other.locationLat == locationLat &&
        listEquals(other.sponsors, sponsors) &&
        other.time == time &&
        listEquals(other.dynamicform, dynamicform) &&
        other.name == name &&
        other.live == live &&
        other.payment_type == payment_type &&
        other.date == date &&
        other.reqdfields == reqdfields &&
        other.reglink == reglink &&
        other.structure == structure &&
        other.image == image &&
        other.about == about &&
        other.category == category &&
        other.sk == sk &&
        other.pk == pk &&
        other.id == id &&
        other.sortCategory == sortCategory &&
        other.timeline == timeline &&
        listEquals(other.gallery, gallery) &&
        other.contact == contact;
  }

  @override
  int get hashCode {
    return headerImage.hashCode ^
        edition.hashCode ^
        location.hashCode ^
        mode.hashCode ^
        pricepool.hashCode ^
        timestamp.hashCode ^
        oneliner.hashCode ^
        startdate.hashCode ^
        locationLng.hashCode ^
        locationLat.hashCode ^
        sponsors.hashCode ^
        time.hashCode ^
        dynamicform.hashCode ^
        name.hashCode ^
        live.hashCode ^
        payment_type.hashCode ^
        date.hashCode ^
        reqdfields.hashCode ^
        reglink.hashCode ^
        structure.hashCode ^
        image.hashCode ^
        about.hashCode ^
        category.hashCode ^
        sk.hashCode ^
        pk.hashCode ^
        id.hashCode ^
        sortCategory.hashCode ^
        timeline.hashCode ^
        gallery.hashCode ^
        contact.hashCode;
  }
}
