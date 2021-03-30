import 'package:flutter_hooks/flutter_hooks.dart';

void useOnce(Function function) => useEffect(() {
      function();
    }, []);
