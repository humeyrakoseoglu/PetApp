import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet/features/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
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

  UserModel({
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
      this.totalPosts}) : super(
      uid:uid,
      totalFollowing: totalFollowing,
      followers: followers,
      username:username,
      name:name,
      bio:bio,
      website:website,
      email: email,
      profileUrl:profileUrl,
      following:following,
      totalFollowers: totalFollowers,
      totalPosts: totalPosts,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot['email'],
      uid: snapshot['uid'],
      totalFollowers: snapshot['totalFollowers'],
      totalPosts: snapshot['totalPosts'],
      profileUrl: snapshot['profileUrl'],
      website: snapshot['website'],
      bio: snapshot['bio'],
      username: snapshot['username'],
      totalFollowing: snapshot['totalFollowing'],
      name: snapshot['name'],
      followers: List.from(snap.get("followers")), // listler için böyle yapıyoruz
      following: List.from(snap.get("following")),
    );
  }

  Map<String, dynamic> toJson() => {
    "uid":uid,
    "totalFollowing": totalFollowing,
    "followers": followers,
    "username":username,
    "name":name,
    "bio":bio,
    "website":website,
    "email": email,
    "profileUrl":profileUrl,
    "following":following,
    "totalFollowers": totalFollowers,
    "totalPosts": totalPosts
  };

}
