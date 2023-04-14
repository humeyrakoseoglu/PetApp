
import 'dart:io';

import 'package:equatable/equatable.dart';
//Equatable that’s a package for value equality you can checkout it’s documentation
class UserEntity extends Equatable{ // deger esitligi icin kullanilir hash code
  final String? uid;
  final String? username;
  final String? name;
  final String? bio;
  final String? website;
  final String? email;
  final String? profileUrl;
  final List? followers;
  final List? following;
  final num? totalFollowers;
  final num? totalFollowing;
  final num? totalPosts;



  //will not going to store in DB
  final File? imageFile;
  final String? password;
  final String? otherUid;

  UserEntity({
    this.imageFile,
    this.uid,
    this.username,
    this.name,
    this.bio,
    this.website,
    this.email,
    this.profileUrl,
    this.followers,
    this.following,
    this.totalFollowers,
    this.totalFollowing,
    this.totalPosts,
    this.password,
    this.otherUid,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    imageFile,
    uid,
    username,
    name,
    bio,
    website,
    email,
    profileUrl,
    followers,
    following,
    totalFollowers,
    totalFollowing,
    totalPosts,
    password,
    otherUid,
  ];
}
