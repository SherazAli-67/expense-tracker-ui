import 'package:expense_tracker_ui/presentation/screens/home_screen.dart';
import 'package:expense_tracker_ui/presentation/screens/main_menu_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
    initialLocation: NamedRoutes.expenseTracking.routeName,
    routes: [
      StatefulShellRoute.indexedStack(branches: [
        StatefulShellBranch(routes: [
          GoRoute(path:  NamedRoutes.expenseTracking.routeName, builder: (_, state) => ExpenseTrackingScreen()),
        ],),
        StatefulShellBranch(routes: [
          GoRoute(path:  NamedRoutes.wallet.routeName, builder: (_, state) => Center(child: Text("Wallet Page"),)),
        ],),
        StatefulShellBranch(routes: [
          GoRoute(path:  NamedRoutes.expenseTracking.routeName, builder: (_, state) => Center(child: Text("Expense tracking Page"),)),
        ],),
        StatefulShellBranch(routes: [
          GoRoute(path:  NamedRoutes.settings.routeName, builder: (_, state) => Center(child: Text("Settings Page"),)),
        ],),
      ],
        builder: (ctx, state, navigationShell) => MainMenuPage(navigationShell: navigationShell)
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