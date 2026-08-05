import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/auth_provider.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../features/authentication/presentation/login_page.dart';
import '../../features/authentication/presentation/otp_verification_page.dart';
import '../../features/dashboard/presentation/dashboard_page.dart';
import '../../features/employees/presentation/user_management_page.dart';
import '../../features/role_management/presentation/role_management_page.dart';
import '../../features/permission_management/presentation/permission_management_page.dart';
import '../../features/good_receive/presentation/good_receive_page.dart';
import '../../features/transfer_putaway/presentation/transfer_putaway_page.dart';
import '../../features/settings/presentation/settings_page.dart';

/// Maps a route path to the title shown in the top bar.
const Map<String, String> routeTitles = {
  '/dashboard': 'Dashboard',
  '/user_management': 'User Management',
  '/role_management': 'Role Management',
  '/permission_management': 'Permission Management',
  '/good_receive': 'Good Receive',
  '/transfer_putaway': 'Transfer & Putaway',
  '/settings': 'Settings',
};

/// Riverpod provider exposing a single GoRouter instance for the app.
final routerProvider = Provider<GoRouter>((ref) => _buildRouter(ref));

/// Builds the app's GoRouter, watching [isLoggedInProvider] so that
/// navigating while logged out always redirects back to /login.
GoRouter _buildRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: _AuthListenable(ref),
    redirect: (context, state) {
      final loggedIn = ref.read(isLoggedInProvider);
      final loggingIn = state.matchedLocation == '/login' ||
          state.matchedLocation == '/otp-verification';

      if (!loggedIn && !loggingIn) return '/login';
      if (loggedIn && loggingIn) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/otp-verification',
        builder: (context, state) {
          final email = state.extra is String ? state.extra as String : '';
          return OtpVerificationPage(email: email);
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          final route = state.matchedLocation;
          return _ShellWrapper(route: route, child: child);
        },
        routes: [
          GoRoute(path: '/dashboard', builder: (context, state) => const DashboardPage()),
          GoRoute(path: '/user_management', builder: (context, state) => const UserManagementPage()),
          GoRoute(path: '/role_management', builder: (context, state) => const RoleManagementPage()),
          GoRoute(path: '/permission_management', builder: (context, state) => const PermissionManagementPage()),
          GoRoute(path: '/good_receive', builder: (context, state) => const GoodReceivePage()),
          GoRoute(path: '/transfer_putaway', builder: (context, state) => const TransferPutawayPage()),
          GoRoute(path: '/settings', builder: (context, state) => const SettingsPage()),
        ],
      ),
    ],
  );
}

/// Wraps every shell route in [AppScaffold], wiring up navigation & logout.
class _ShellWrapper extends ConsumerWidget {
  final String route;
  final Widget child;

  const _ShellWrapper({required this.route, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      currentRoute: route,
      pageTitle: routeTitles[route] ?? '',
      onNavigate: (r) => context.go(r),
      onLogout: () {
        ref.read(isLoggedInProvider.notifier).state = false;
        context.go('/login');
      },
      child: child,
    );
  }
}

/// Bridges a Riverpod provider to GoRouter's Listenable-based refresh API,
/// so the router re-evaluates `redirect` whenever login state changes.
class _AuthListenable extends ChangeNotifier {
  _AuthListenable(Ref ref) {
    ref.listen(isLoggedInProvider, (previous, next) => notifyListeners());
  }
}
