import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/responsive.dart';
import 'app_sidebar.dart';
import 'app_topbar.dart';

/// The shared authenticated layout: Sidebar + TopBar + page content.
/// On mobile the sidebar collapses into a Drawer opened via the menu icon.
/// This wraps every route inside the app's ShellRoute (see app_router.dart).
class AppScaffold extends StatelessWidget {
  final String currentRoute;
  final String pageTitle;
  final Widget child;
  final ValueChanged<String> onNavigate;
  final VoidCallback onLogout;

  const AppScaffold({
    super.key,
    required this.currentRoute,
    required this.pageTitle,
    required this.child,
    required this.onNavigate,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    if (isDesktop) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Row(
          children: [
            AppSidebar(currentRoute: currentRoute, onNavigate: onNavigate),
            Expanded(
              child: Column(
                children: [
                  AppTopBar(title: pageTitle, onLogout: onLogout),
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Mobile / tablet: sidebar becomes a Drawer.
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: Drawer(
        backgroundColor: AppColors.sidebarBackground,
        child: AppSidebar(
          currentRoute: currentRoute,
          onNavigate: (route) {
            Navigator.of(context).pop(); // close drawer first
            onNavigate(route);
          },
        ),
      ),
      body: Builder(
        builder: (innerContext) => Column(
          children: [
            AppTopBar(
              title: pageTitle,
              onMenuTap: () => Scaffold.of(innerContext).openDrawer(),
              onLogout: onLogout,
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
