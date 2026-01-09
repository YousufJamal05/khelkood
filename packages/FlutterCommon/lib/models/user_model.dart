// This source code was written for the khelkood monorepo.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String? email;
  final String? phoneNumber;
  final String? displayName;
  final String? photoUrl;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;

  const UserModel({
    required this.id,
    this.email,
    this.phoneNumber,
    this.displayName,
    this.photoUrl,
    this.createdAt,
    this.lastLoginAt,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        phoneNumber,
        displayName,
        photoUrl,
        createdAt,
        lastLoginAt,
      ];

  UserModel copyWith({
    String? id,
    String? email,
    String? phoneNumber,
    String? displayName,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      id: snapshot.id,
      email: data?['email'],
      phoneNumber: data?['phoneNumber'],
      displayName: data?['displayName'],
      photoUrl: data?['photoUrl'],
      createdAt: (data?['createdAt'] as Timestamp?)?.toDate(),
      lastLoginAt: (data?['lastLoginAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (displayName != null) 'displayName': displayName,
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
      if (lastLoginAt != null) 'lastLoginAt': Timestamp.fromDate(lastLoginAt!),
    };
  }
}
