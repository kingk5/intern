import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'advice.dart';


class Providers{
  static final adviceProvider = ChangeNotifierProvider<AdviceProvider>((ref){
    return AdviceProvider();
  });
}