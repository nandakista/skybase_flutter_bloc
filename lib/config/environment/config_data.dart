import 'package:skybase/config/network/api_token_manager.dart';

/// Define your environment based variable here
/// This data class will provided variable that have different value in every
/// environments such as :
/// 1. BaseUrl
/// 2. API key
/// 3. etc.
///
/// This data below is an example, you can delete or replace based on your requirement
class Config {
  Config({
    required this.baseUrl,
    required this.tokenType,
    required this.githubToken,
  });

  String baseUrl;
  TokenType tokenType;
  String githubToken;
}