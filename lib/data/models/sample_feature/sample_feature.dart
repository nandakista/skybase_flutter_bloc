import 'package:skybase/data/models/repo/repo.dart';

class SampleFeature {
  int id;
  String username;
  String? name;
  String? location;
  String? company;
  String? gitUrl;
  String? bio;
  String? avatarUrl;
  int? repository;
  int? followers;
  int? following;
  List<Repo>? repositoryList;
  List<SampleFeature>? followersList;
  List<SampleFeature>? followingList;

  SampleFeature({
    required this.id,
    required this.username,
    this.name,
    this.location,
    this.company,
    this.gitUrl,
    this.bio,
    this.avatarUrl,
    this.repository,
    this.followers,
    this.following,
    this.repositoryList,
    this.followersList,
    this.followingList,
  });

  factory SampleFeature.fromJson(Map<dynamic, dynamic> json) {
    return SampleFeature(
      id: json['id'],
      username: json['login'],
      name: json['name'],
      location: json['location'],
      company: json['company'],
      gitUrl: json['html_url'],
      bio: json['bio'],
      avatarUrl: json['avatar_url'],
      repository: json['public_repos'],
      followers: json['followers'],
      following: json['following'],
      repositoryList: (json['repository_list'] as List?)
          ?.map((e) => Repo.fromJson(e as Map<String, dynamic>))
          .toList(),
      followersList: (json['followers_list'] as List?)
          ?.map((e) => SampleFeature.fromJson(e as Map<String, dynamic>))
          .toList(),
      followingList: (json['following_list'] as List?)
          ?.map((e) => SampleFeature.fromJson(e as Map<String, dynamic>))
          .toList(),
      // token: json['token'],
      // refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'login': username,
        'name': name,
        'location': location,
        'company': company,
        'html_url': gitUrl,
        'bio': bio,
        'avatar_url': avatarUrl,
        'public_repos': repository,
        'followers': followers,
        'following': following,
        'repository_list':
            List<dynamic>.from(repositoryList?.map((x) => x.toJson()) ?? []),
        'following_list':
            List<dynamic>.from(followingList?.map((x) => x.toJson()) ?? []),
        'followers_list':
            List<dynamic>.from(followersList?.map((x) => x.toJson()) ?? []),
        // 'token': token,
        // 'refresh_token': refreshToken,
      };
}
