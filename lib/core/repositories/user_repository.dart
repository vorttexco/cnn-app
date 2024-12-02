import 'dart:convert';
import 'dart:io';

import 'package:cnn_brasil_app/core/index.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum LoginType { commom, google, apple }

class UserRepository implements Repository<UserModel> {
  final InterfaceHttpClient client;

  UserRepository(this.client);

  @override
  Future<BaseResponse> create(UserModel model) async {
    Logger.log(json.encode({'token': model.token}));

    final request = BaseRequest(
        path: ApiAuth.auth,
        body: {'token': model.token, 'device': model.device});
    return await client.post(request);
  }

  @override
  Future<BaseResponse> delete(UserModel model) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> get(String? id) async {
    String? userJson = await StorageManager()
        .getString(AppConstants.SHARED_PREFERENCES_SAVE_USER);

    if (userJson == null) return null;
    return UserModel.fromJson(json.decode(userJson));
  }

  @override
  Future<List<UserModel>> listAll() async {
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> update(UserModel model) {
    throw UnimplementedError();
  }

  Future<bool> save(UserModel user) async {
    await StorageManager().setString(
        AppConstants.SHARED_PREFERENCES_SAVE_USER, json.encode(user.toJson()));
    return true;
  }

  Future<void> logout() async {
    final googleSignIn = GoogleSignIn(
      clientId: Platform.isIOS
          ? AppConstants.GOOGLE_CLIENT_IOS
          : AppConstants.GOOGLE_CLIENT_ANDROID,
      scopes: ['email'],
    );
    await googleSignIn.signOut();
    await StorageManager().reset();
  }

  Future login(LoginType type) async {
    switch (type) {
      case LoginType.commom:
      // TODO: Handle this case.
      case LoginType.google:
      // TODO: Handle this case.
      case LoginType.apple:
        final credentials = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'com.cnn.brasil.service',
            redirectUri: Uri.parse(
                'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple'),
          ),
        );
    }
  }
}
