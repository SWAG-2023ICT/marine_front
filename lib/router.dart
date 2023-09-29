import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/features/user/bookmark/user_bookmark_screen.dart';
import 'package:swag_marine_products/features/user/home/user_home_screen.dart';
import 'package:swag_marine_products/features/user/navigation/navigation_screen.dart';
import 'package:swag_marine_products/features/sign_in_up/sign_in_screen.dart';
import 'package:swag_marine_products/features/sign_in_up/sign_up_screen.dart';
import 'package:swag_marine_products/features/user/profile/user_inform_inquiry_screen.dart';
import 'package:swag_marine_products/features/user/profile/user_inform_screen.dart';
import 'package:swag_marine_products/features/user/profile/user_inform_update_screen.dart';

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
      name: UserHomeScreen.routeName,
      path: UserHomeScreen.routeURL,
      builder: (context, state) => const UserHomeScreen(),
      routes: [
        GoRoute(
          name: NavigationScreen.routeName,
          path: NavigationScreen.routeURL,
          builder: (context, state) {
            if (state.extra != null) {
              final args = state.extra as NavigationScreenArgs;
              return NavigationScreen(
                selectedIndex: args.selectedIndex,
              );
            }
            return const NavigationScreen(
              selectedIndex: 0,
            );
          },
        ),
        GoRoute(
          name: UserBookMarkScreen.routeName,
          path: UserBookMarkScreen.routeURL,
          builder: (context, state) => const UserBookMarkScreen(),
        ),
        GoRoute(
          name: UserInformScreen.routeName,
          path: UserInformScreen.routeURL,
          builder: (context, state) => const UserInformScreen(),
          routes: [
            GoRoute(
              name: UserInformInquiryScreen.routeName,
              path: UserInformInquiryScreen.routeURL,
              builder: (context, state) => const UserInformInquiryScreen(),
              routes: [
                GoRoute(
                  name: UserInformUpdateScreen.routeName,
                  path: UserInformUpdateScreen.routeURL,
                  builder: (context, state) {
                    final args = state.extra as UserInformUpdateScreenArgs;
                    return UserInformUpdateScreen(
                      updateType: args.updateType,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
