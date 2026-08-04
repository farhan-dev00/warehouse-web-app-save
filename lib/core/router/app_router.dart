import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/auth_provider.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../features/authentication/presentation/login_page.dart';
import '../../features/authentication/presentation/otp_verification_page.dart';
import '../../features/dashboard/presentation/dashboard_page.dart';
import '../../features/employees/presentation/employees_page.dart';
import '../../features/departments/presentation/departments_page.dart';
import '../../features/attendance/presentation/attendance_page.dart';
import '../../features/leave/presentation/leave_page.dart';
import '../../features/payroll/presentation/payroll_page.dart';
import '../../features/reports/presentation/reports_page.dart';
import '../../features/settings/presentation/settings_page.dart';

/// Maps a route path to the title shown in the top bar.
const Map<String, String> routeTitles = {
  '/dashboard': 'Dashboard',
  '/employees': 'Employees',
  '/departments': 'Departments',
  '/attendance': 'Attendance',
  '/leave': 'Leave Management',
  '/payroll': 'Payroll',
  '/reports': 'Reports',
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
          GoRoute(path: '/employees', builder: (context, state) => const EmployeesPage()),
          GoRoute(path: '/departments', builder: (context, state) => const DepartmentsPage()),
          GoRoute(path: '/attendance', builder: (context, state) => const AttendancePage()),
          GoRoute(path: '/leave', builder: (context, state) => const LeavePage()),
          GoRoute(path: '/payroll', builder: (context, state) => const PayrollPage()),
          GoRoute(path: '/reports', builder: (context, state) => const ReportsPage()),
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
