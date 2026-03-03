import 'package:willy_o/core/constants/env.dart';
import 'package:willy_o/main.dart' as app;

void main() {
  Env.init(
    environment: Environment.development,
    apiBaseUrl: 'https://dev.api.willy-o.com',
  );
  app.main();
}
