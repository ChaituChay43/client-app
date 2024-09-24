import 'package:go_router/go_router.dart';

class NavigationService {
  final GoRouter router;

  NavigationService(this.router);

  void go(String path) => router.go(path);

  void push(String path) => router.push(path);

  void pop() => router.pop();

  void pushNamed(String name, {Map<String, String>? params, Object? extra}) {
    router.pushNamed(name, pathParameters: params ?? {}, extra: extra);
  }
}
