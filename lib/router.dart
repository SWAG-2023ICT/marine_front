import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/screens/navigation_screen.dart';
import 'package:swag_marine_products/screens/sign_in_up/sign_in_screen.dart';
import 'package:swag_marine_products/screens/sign_in_up/sign_up_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignInScreen.routeName,
      path: SignInScreen.routeURL,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) {
        if (state.extra != null) {
          final args = state.extra as SignUpScreenArgs;
          return SignUpScreen(
            isStored: args.isStored,
          );
        }
        return const SignUpScreen();
      },
    ),
    GoRoute(
      name: NavigationScreen.routeName,
      path: NavigationScreen.routeURL,
      builder: (context, state) => const NavigationScreen(),
    ),
  ],
);
