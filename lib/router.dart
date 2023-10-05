import 'package:go_router/go_router.dart';
import 'package:swag_marine_products/features/store/menu/store_menu_add_screen.dart';
import 'package:swag_marine_products/features/store/navigation/store_navigation_screen.dart';
import 'package:swag_marine_products/features/store/profile/store_inform_inquiry_screen.dart';
import 'package:swag_marine_products/features/store/profile/store_inform_screen.dart';
import 'package:swag_marine_products/features/store/profile/store_inform_update_screen.dart';
import 'package:swag_marine_products/features/store/profile/store_user_inform_inquiry_screen.dart';
import 'package:swag_marine_products/features/store/profile/store_user_inform_update_screen.dart';
import 'package:swag_marine_products/features/user/navigation/user_navigation_screen.dart';
import 'package:swag_marine_products/features/sign_in_up/sign_in_screen.dart';
import 'package:swag_marine_products/features/sign_in_up/sign_up_screen.dart';
import 'package:swag_marine_products/features/user/order/user_order_screen.dart';
import 'package:swag_marine_products/features/user/profile/user_inform_inquiry_screen.dart';
import 'package:swag_marine_products/features/user/profile/user_inform_screen.dart';
import 'package:swag_marine_products/features/user/profile/user_inform_update_screen.dart';
import 'package:swag_marine_products/features/user/radioactivity/radioactivity_detail_screen.dart';

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
      name: UserNavigationScreen.routeName,
      path: UserNavigationScreen.routeURL,
      builder: (context, state) {
        if (state.extra != null) {
          final args = state.extra as UserNavigationScreenArgs;
          return UserNavigationScreen(
            selectedIndex: args.selectedIndex,
          );
        }
        return const UserNavigationScreen(
          selectedIndex: 0,
        );
      },
      routes: [
        GoRoute(
          path: RadioactivityDetailScreen.routeURL,
          name: RadioactivityDetailScreen.routeName,
          builder: (context, state) => const RadioactivityDetailScreen(),
        ),
        GoRoute(
          path: UserOrderScreen.routeURL,
          name: UserOrderScreen.routeName,
          builder: (context, state) => const UserOrderScreen(),
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
    // -------------- 홈페이지를 만들었을 경우 --------------
    // GoRoute(
    //   name: UserHomeScreen.routeName,
    //   path: UserHomeScreen.routeURL,
    //   builder: (context, state) => const UserHomeScreen(),
    //   routes: [
    //     GoRoute(
    //       path: RadioactivityDetailScreen.routeURL,
    //       name: RadioactivityDetailScreen.routeName,
    //       builder: (context, state) => const RadioactivityDetailScreen(),
    //     ),
    //     GoRoute(
    //       name: NavigationScreen.routeName,
    //       path: NavigationScreen.routeURL,
    //       builder: (context, state) {
    //         if (state.extra != null) {
    //           final args = state.extra as NavigationScreenArgs;
    //           return NavigationScreen(
    //             selectedIndex: args.selectedIndex,
    //           );
    //         }
    //         return const NavigationScreen(
    //           selectedIndex: 0,
    //         );
    //       },
    //     ),
    //     GoRoute(
    //       name: UserBookMarkScreen.routeName,
    //       path: UserBookMarkScreen.routeURL,
    //       builder: (context, state) => const UserBookMarkScreen(),
    //     ),
    //     GoRoute(
    //       name: UserInformScreen.routeName,
    //       path: UserInformScreen.routeURL,
    //       builder: (context, state) => const UserInformScreen(),
    //       routes: [
    //         GoRoute(
    //           name: UserInformInquiryScreen.routeName,
    //           path: UserInformInquiryScreen.routeURL,
    //           builder: (context, state) => const UserInformInquiryScreen(),
    //           routes: [
    //             GoRoute(
    //               name: UserInformUpdateScreen.routeName,
    //               path: UserInformUpdateScreen.routeURL,
    //               builder: (context, state) {
    //                 final args = state.extra as UserInformUpdateScreenArgs;
    //                 return UserInformUpdateScreen(
    //                   updateType: args.updateType,
    //                 );
    //               },
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
    GoRoute(
      path: StoreNavigationScreen.routeURL,
      name: StoreNavigationScreen.routeName,
      builder: (context, state) {
        if (state.extra != null) {
          final args = state.extra as StoreNavigationScreenArgs;
          return StoreNavigationScreen(
            selectedIndex: args.selectedIndex,
          );
        }
        return const StoreNavigationScreen(
          selectedIndex: 0,
        );
      },
      routes: [
        GoRoute(
          path: StoreMenuAddScreen.routeURL,
          name: StoreMenuAddScreen.routeName,
          builder: (context, state) => const StoreMenuAddScreen(),
        ),
        GoRoute(
          name: StoreInformScreen.routeName,
          path: StoreInformScreen.routeURL,
          builder: (context, state) => const StoreInformScreen(),
          routes: [
            GoRoute(
              name: StoreInformInquiryScreen.routeName,
              path: StoreInformInquiryScreen.routeURL,
              builder: (context, state) => const StoreInformInquiryScreen(),
              routes: [
                GoRoute(
                  name: StoreInformUpdateScreen.routeName,
                  path: StoreInformUpdateScreen.routeURL,
                  builder: (context, state) {
                    final args = state.extra as StoreInformUpdateScreenArgs;
                    return StoreInformUpdateScreen(
                      updateType: args.updateType,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              name: StoreUserInformInquiryScreen.routeName,
              path: StoreUserInformInquiryScreen.routeURL,
              builder: (context, state) => const StoreUserInformInquiryScreen(),
              routes: [
                GoRoute(
                  name: StoreUserInformUpdateScreen.routeName,
                  path: StoreUserInformUpdateScreen.routeURL,
                  builder: (context, state) {
                    final args = state.extra as StoreUserInformUpdateScreenArgs;
                    return StoreUserInformUpdateScreen(
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
