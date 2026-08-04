import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fake authentication state. Login/Logout just flips this boolean —
/// there is no real backend in this project. The router listens to this
/// provider to decide whether to redirect to /login.
final isLoggedInProvider = StateProvider<bool>((ref) => false);
