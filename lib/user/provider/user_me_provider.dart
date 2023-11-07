import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/secure_storage/secure_storage.dart';
import 'package:coding_factory_train/user/model/user_model.dart';
import 'package:coding_factory_train/user/repository/auth_repository.dart';
import 'package:coding_factory_train/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final repository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return UserMeStateNotifier(
      repository: repository, storage: storage, authRepository: authRepository);
});

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  final AuthRepository authRepository;

  UserMeStateNotifier(
      {required this.repository,
      required this.storage,
      required this.authRepository})
      : super(UserModelLoading()) {
    getMe();
  }

  Future<void> getMe() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN);
    final refreshToken = await storage.read(key: REFRESH_TOKEN);
    logger.d(refreshToken);
    if (accessToken == null || refreshToken == null) {
      state = null;
      return;
    }

    final resp = await repository.getMe();
    state = resp;
  }

  Future<UserModelBase> login({required String id, required String pw}) async {
    try {
      state = UserModelLoading();

      final resp = await authRepository.login(id: id, pw: pw);

      await Future.wait([
        storage.write(key: ACCESS_TOKEN, value: resp.accessToken),
        storage.write(key: REFRESH_TOKEN, value: resp.refreshToken),
      ]);

      final userResp = await repository.getMe();

      return userResp;
    } catch (e) {
      state = UserModelError(errorMessage: "로그인에 실패했습니다. ");
      return Future.value(state);
    }
  }

  logout() async {
    state = null;

    await Future.wait([
      storage.delete(key: REFRESH_TOKEN),
      storage.delete(key: ACCESS_TOKEN),
    ]);
  }
}
