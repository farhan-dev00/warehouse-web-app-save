# Project conventions

- Feature-first architecture: features/<name>/{presentation,models}/
- Colors/sizes/strings live in core/constants/ — never hardcode a color/spacing value in a widget
- Routing via GoRouter in core/router/app_router.dart
- Auth state: core/services/auth_provider.dart (isLoggedInProvider, StateProvider<bool>)
- No backend — dummy actions call shared/dialogs/action_dialog.dart's showActionDialog()
- Reusable widgets go in shared/widgets/