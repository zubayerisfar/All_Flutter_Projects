import "package:go_router/go_router.dart";
import "screens/homepage.dart";
import "screens/profile.dart";

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'home-sample',
          name: 'home-sample',
          builder: (context, state) => const HomePageSampleView(),
        ),
      ],
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
      routes: [
        GoRoute(
          path: 'sample',
          name: 'profile-sample',
          builder: (context, state) => const SampleViewInsideScaffold(),
        ),
      ],
    ),
  ],
);
