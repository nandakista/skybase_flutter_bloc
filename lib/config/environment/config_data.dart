import 'package:skybase/config/network/api_token_manager.dart';

class Config {
  Config({
    required this.baseUrl,
    required this.clientToken,
    required this.tokenType,
  });

  String baseUrl;
  String clientToken;
  TokenType tokenType;
}