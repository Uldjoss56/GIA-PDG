import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/models/user_message.dart';

class UserMessagesNotifier extends StateNotifier<Map<String, UserMessages>> {
  UserMessagesNotifier(
    super.userMessages,
  );

  void updateUserMessages(Map<String, UserMessages> userMessages) {
    state = userMessages;
  }
}

final userMessagesProvider =
    StateNotifierProvider<UserMessagesNotifier, Map<String, UserMessages>>(
  (ref) => UserMessagesNotifier(
    {},
  ),
);
