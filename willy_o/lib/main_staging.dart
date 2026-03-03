import 'package:willy_o/core/constants/env.dart';
import 'package:willy_o/main.dart' as app;

void main() {
  Env.init(
    environment: Environment.staging,
    apiBaseUrl: 'https://staging.api.willy-o.com',
  );
  app.main();
}
