import 'package:skybase/config/network/api_token_manager.dart';

class Config {
  Config({
    required this.baseUrl,
    required this.githubToken,
    required this.tokenType,
  });

  String baseUrl;
  String githubToken;
  TokenType tokenType;
}