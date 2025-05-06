export 'config/path_strategy/hw_none.dart'
    if (dart.library.io) 'config/path_strategy/hw_io.dart'
    if (dart.library.js_interop) 'config/path_strategy/hw_web.dart';