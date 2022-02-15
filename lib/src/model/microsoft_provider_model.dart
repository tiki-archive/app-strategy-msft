class MicrosoftProviderModel{
  bool isLinked = false;
  String? displayName;
  String? email;
  String? token;
  DateTime? accessTokenExp;
  String? refreshToken;

  MicrosoftProviderModel({
    this.isLinked = false,
    this.displayName,
    this.email,
    this.token,
    this.accessTokenExp,
    this.refreshToken
  });
}