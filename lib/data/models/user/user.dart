class User {
  int? id;
  String? token;
  String? refreshToken;
  String? username;
  String? name;
  String? location;
  String? company;
  String? gitUrl;
  String? bio;
  String? avatarUrl;
  int? repository;
  int? followers;
  int? following;

  User({
    this.id,
    this.token,
    this.refreshToken,
    this.username,
    this.name,
    this.location,
    this.company,
    this.gitUrl,
    this.bio,
    this.avatarUrl,
    this.repository,
    this.followers,
    this.following,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json['id'],
      token: json['token'],
      refreshToken: json['refresh_token'],
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
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'token': token,
    'refresh_token': refreshToken,
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
  };
}
