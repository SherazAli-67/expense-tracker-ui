import 'package:expense_tracker_ui/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
    initialLocation: NamedRoutes.home.routeName,
    routes: [
      GoRoute(path:  NamedRoutes.home.routeName, builder: (_, state) => HomeScreen())
    ],
);

enum NamedRoutes {
  home('/home');

  final String routeName;
  const NamedRoutes(this.routeName);
}