
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


List<SingleChildWidget> providers = [
  ...independentProviders
];

List<SingleChildWidget> independentProviders = [
  // ChangeNotifierProvider(create: (_) => UserProvider()),
  // ChangeNotifierProvider(create: (_) => UserProvider()),
];
