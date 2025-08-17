import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vintage_1020/domain/models/model/user/user.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  
  
  @override
  User build() {
    return User(
      userEmail: '',
      userName: null,
      userInventoryId: null,
    );
  }

  void setUserEmail(String email) {
    state = state.copyWith(userEmail: email);
  }
}