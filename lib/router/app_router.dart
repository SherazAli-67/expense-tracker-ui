import 'package:expense_tracker_ui/presentation/screens/home_screen.dart';
import 'package:expense_tracker_ui/presentation/screens/main_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.expenseTracking.routeName,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (ctx, state, navigationShell) => MainMenuPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.expenseTracking.routeName, builder: (_, state) => const ExpenseTrackingScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.wallet.routeName, builder: (_, state) => const Center(child: Text('Wallet Page'))),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.chart.routeName, builder: (_, state) => const Center(child: Text('Chart Page'))),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.settings.routeName, builder: (_, state) => const Center(child: Text('Settings Page'))),
        ]),
      ],
    ),
  ],
);

enum NamedRoutes {
  expenseTracking('/expense-tracking'),
  wallet('/wallet'),
  chart('/chart'),
  settings('/settings')
  ;

  final String routeName;
  const NamedRoutes(this.routeName);
}
