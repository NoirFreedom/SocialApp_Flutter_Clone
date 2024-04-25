import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetChatRoomsInfoViewModel extends AsyncNotifier<String> {
  @override
  FutureOr<String> build() {
    return "";
  }
}

final getChatroomsInfoProvider =
    AsyncNotifierProvider<GetChatRoomsInfoViewModel, String>(
  () => GetChatRoomsInfoViewModel(),
);
