import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

final GetIt _getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => _getIt.init();
