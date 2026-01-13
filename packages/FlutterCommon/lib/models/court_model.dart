// This source code was written for the khelkood monorepo.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CourtModel extends Equatable {
  final String courtId;
  final String ownerId;
  final String name;
  final String description;
  final String sportType;
  final String area;
  final String address;
  final String? location; // Changed to String for Google Maps link
  final Map<String, dynamic> pricing;
  final List<String> photos;
  final List<String> amenities;
  final Map<String, dynamic> operationalHours;
  final int slotDuration;
  final int maxAdvanceBooking;
  final Map<String, dynamic> cancellationPolicy;
  final String isVerified; // 'pending', 'approved', 'rejected'
  final double rating;
  final int reviewCount;
  final DateTime? createdAt;

  const CourtModel({
    required this.courtId,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.sportType,
    required this.area,
    required this.address,
    this.location,
    required this.pricing,
    required this.photos,
    required this.amenities,
    required this.operationalHours,
    required this.slotDuration,
    required this.maxAdvanceBooking,
    required this.cancellationPolicy,
    this.isVerified = 'pending',
    this.rating = 0.0,
    this.reviewCount = 0,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        courtId,
        ownerId,
        name,
        description,
        sportType,
        area,
        address,
        location,
        pricing,
        photos,
        amenities,
        operationalHours,
        slotDuration,
        maxAdvanceBooking,
        cancellationPolicy,
        isVerified,
        rating,
        reviewCount,
        createdAt,
      ];

  CourtModel copyWith({
    String? courtId,
    String? ownerId,
    String? name,
    String? description,
    String? sportType,
    String? area,
    String? address,
    String? location,
    Map<String, dynamic>? pricing,
    List<String>? photos,
    List<String>? amenities,
    Map<String, dynamic>? operationalHours,
    int? slotDuration,
    int? maxAdvanceBooking,
    Map<String, dynamic>? cancellationPolicy,
    String? isVerified,
    double? rating,
    int? reviewCount,
    DateTime? createdAt,
  }) {
    return CourtModel(
      courtId: courtId ?? this.courtId,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      description: description ?? this.description,
      sportType: sportType ?? this.sportType,
      area: area ?? this.area,
      address: address ?? this.address,
      location: location ?? this.location,
      pricing: pricing ?? this.pricing,
      photos: photos ?? this.photos,
      amenities: amenities ?? this.amenities,
      operationalHours: operationalHours ?? this.operationalHours,
      slotDuration: slotDuration ?? this.slotDuration,
      maxAdvanceBooking: maxAdvanceBooking ?? this.maxAdvanceBooking,
      cancellationPolicy: cancellationPolicy ?? this.cancellationPolicy,
      isVerified: isVerified ?? this.isVerified,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory CourtModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CourtModel.fromMap(data ?? {}, id: snapshot.id);
  }

  factory CourtModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return CourtModel(
      courtId: id ?? map['courtId'] ?? '',
      ownerId: map['ownerId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      sportType: map['sportType'] ?? '',
      area: map['area'] ?? '',
      address: map['address'] ?? '',
      location: map['location']?.toString(), // Google Maps Link
      pricing: Map<String, dynamic>.from(map['pricing'] ?? {}),
      photos: List<String>.from(map['photos'] ?? []),
      amenities: List<String>.from(map['amenities'] ?? []),
      operationalHours:
          Map<String, dynamic>.from(map['operationalHours'] ?? {}),
      slotDuration: map['slotDuration'] ?? 60,
      maxAdvanceBooking: map['maxAdvanceBooking'] ?? 30,
      cancellationPolicy:
          Map<String, dynamic>.from(map['cancellationPolicy'] ?? {}),
      isVerified: map['isVerified']?.toString() ?? 'pending',
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      createdAt: _parseDateTime(map['createdAt']),
    );
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  Map<String, dynamic> toMap() {
    return {
      'courtId': courtId,
      'ownerId': ownerId,
      'name': name,
      'description': description,
      'sportType': sportType,
      'area': area,
      'address': address,
      if (location != null) 'location': location,
      'pricing': pricing,
      'photos': photos,
      'amenities': amenities,
      'operationalHours': operationalHours,
      'slotDuration': slotDuration,
      'maxAdvanceBooking': maxAdvanceBooking,
      'cancellationPolicy': cancellationPolicy,
      'isVerified': isVerified,
      'rating': rating,
      'reviewCount': reviewCount,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'ownerId': ownerId,
      'name': name,
      'description': description,
      'sportType': sportType,
      'area': area,
      'address': address,
      if (location != null) 'location': location,
      'pricing': pricing,
      'photos': photos,
      'amenities': amenities,
      'operationalHours': operationalHours,
      'slotDuration': slotDuration,
      'maxAdvanceBooking': maxAdvanceBooking,
      'cancellationPolicy': cancellationPolicy,
      'isVerified': isVerified,
      'rating': rating,
      'reviewCount': reviewCount,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
    };
  }
}
