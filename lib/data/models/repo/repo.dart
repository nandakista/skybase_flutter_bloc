import 'package:skybase/data/models/sample_feature/sample_feature.dart';

class Repo {
  String name;
  SampleFeature owner;
  String? description;
  String? language;
  int? totalWatch;
  int? totalFork;
  int? totalStar;

  Repo({
    required this.name,
    required this.owner,
    this.description,
    this.language,
    this.totalWatch,
    this.totalFork,
    this.totalStar,
  });

  factory Repo.fromJson(Map<dynamic, dynamic> json) {
    return Repo(
      name: json['full_name'],
      owner: SampleFeature.fromJson(json['owner']),
      description: json['description'],
      language: json['language'],
      totalWatch: json['watchers_count'],
      totalFork: json['forks_count'],
      totalStar: json['stargazers_count'],
    );
  }

  Map<String, dynamic> toJson() => {
    'full_name': name,
    'owner': owner.toJson(),
    'description': description,
    'language': language,
    'watchers_count': totalWatch,
    'forks_count': totalFork,
    'stargazers_count': totalStar,
  };
}
