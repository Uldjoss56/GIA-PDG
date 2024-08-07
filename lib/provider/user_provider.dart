import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/models/user.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier(super.user);

  void updateUser(User user) {
    state = user;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) => UserNotifier(
    User(),
  ),
);

class AllUsersNotifier extends StateNotifier<List<User>> {
  AllUsersNotifier(super.user);

  void updateAllUsers(List<User> allUsers) {
    state = allUsers;
  }
}

final allUsersProvider = StateNotifierProvider<AllUsersNotifier, List<User>>(
  (ref) => AllUsersNotifier(
    List.empty(),
  ),
);

class UserImageNotifier extends StateNotifier<File?> {
  UserImageNotifier(super.userImage);

  void updateUserImage(File? userImage) {
    state = userImage;
  }
}

final userImageProvider =
    StateNotifierProvider<UserImageNotifier, File?>((ref) {
  return UserImageNotifier(null);
});

class SellerNotifier extends StateNotifier<List<User>> {
  SellerNotifier(super.sellers);

  void updateListUser(List<User> sellers) {
    state = sellers;
  }
}

final sellersProvider = StateNotifierProvider<SellerNotifier, List<User>>(
  (ref) => SellerNotifier(
    List.empty(),
  ),
);

class DistributeursNotifier extends StateNotifier<List<User>> {
  DistributeursNotifier(super.distributeurs);

  void updateListUser(List<User> distributeurs) {
    state = distributeurs;
  }
}

final distributeursProvider =
    StateNotifierProvider<DistributeursNotifier, List<User>>(
  (ref) => DistributeursNotifier(
    [],
  ),
);

final distriuteursPaysProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) => UserNotifier(
    User(),
  ),
);

final distributeurOfficielProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) => UserNotifier(
    User(),
  ),
);

final assistantClientProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) => UserNotifier(
    User(),
  ),
);

class AssistNotifier extends StateNotifier<List<User>> {
  AssistNotifier(super.assist);

  void updateListUser(List<User> assist) {
    state = assist;
  }
}

final assistProvider = StateNotifierProvider<AssistNotifier, List<User>>(
  (ref) => AssistNotifier(
    [],
  ),
);
