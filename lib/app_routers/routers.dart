import 'package:firestore_level_up/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

var appRouter = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      }),
]);
