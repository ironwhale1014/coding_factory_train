import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/view/root_tap.dart';
import 'package:coding_factory_train/common/view/splash_screen.dart';
import 'package:coding_factory_train/restaurant/view/restaurant_detail.dart';
import 'package:coding_factory_train/user/model/user_model.dart';
import 'package:coding_factory_train/user/provider/user_me_provider.dart';
import 'package:coding_factory_train/user/view/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  void logout(){
    ref.read(userMeProvider.notifier).logout();
  }

  List<GoRoute> get routes => [
        GoRoute(
            path: "/",
            name: RootTap.routeName,
            builder: (_, __) => const RootTap(),
            routes: [
              GoRoute(
                  path: "restaurant/:rid",
                  name: RestaurantDetailScreen.routeName,
                  builder: (_, state) =>
                      RestaurantDetailScreen(id: state.pathParameters["rid"]!))
            ]),
        GoRoute(
            path: "/splash",
            name: SplashScreen.routeName,
            builder: (_, __) => const SplashScreen()),
        GoRoute(
            path: "/login",
            name: LoginScreen.routeName,
            builder: (_, __) => const LoginScreen()),
      ];



  // 앱 시작 시 토큰 존재 여부 확인 후 로그인으로 갈지 홈 스크린으로 갈지 확인 필요
  String? redirectLogic(GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);
    final bool loggingIn = state.fullPath == "/login";
    logger.d(user);
    logger.d(state.fullPath);

    if (user == null) {
      return loggingIn ? null : "/login";
    }

    logger.d(user);
    if (user is UserModel) {
      return loggingIn || state.fullPath == "/splash" ? "/" : null;
    }

    if (user is UserModelError) {
      return !loggingIn ? "/login" : null;
    }
    return null;
  }
}
