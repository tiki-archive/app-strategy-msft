

class MicrosoftProviderConfig{
  static const String redirectUri = "com.mytiki.app://oauth/";
  static const String clientId = "6e52a878-7251-4669-8e42-70655255a263";
  static const String authorizationEndpoint = "https://login.microsoftonline.com/common/oauth2/v2.0/authorize";
  static const String tokenEndpoint = "https://login.microsoftonline.com/common/oauth2/v2.0/token";
  static const String discoveryUrl = "https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration";
  static const String userinfoEndpoint = "https://graph.microsoft.com/oidc/userinfo";
  static const List<String> promptValues = [
    "select_account"
  ];
  static const List<String> scopes = [
    "openid",
    "email",
    "profile",
    "mail.read",
    "mail.send",
    "offline_access"
  ];
}