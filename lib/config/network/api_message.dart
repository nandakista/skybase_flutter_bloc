/* Created by
   Varcant
   nanda.kista@gmail.com
*/

mixin ApiMessage {

  /// Convert message from BE
  ///
  /// **Ex:**
  /// Be message = User not found, will be translated to *txt_api_user_not_found.tr*
  String convertMessage(String errorMessage) {
    return switch (errorMessage) {
      'User not found' => 'txt_api_user_not_found',
    // Add other..
    // ...
      _ => errorMessage,
    };
  }
}
