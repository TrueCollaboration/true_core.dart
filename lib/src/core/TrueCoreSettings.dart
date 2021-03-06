import 'package:intl/intl.dart';
import 'package:true_core/src/core/typedef.dart';

import 'features/Logger/EAnsiColor.dart';
import 'features/Logger/ELogLevel.dart';

class TrueCoreSettings {
  static final TrueCoreSettings instance = new TrueCoreSettings();
  

  LogPrintFunction logHandler = _defaultLogHandler;


















  static final DateFormat _logFormat = new DateFormat('HH:mm:ss');
  static void _defaultLogHandler(DateTime date, ELogLevel level, Object? tag, Object? msg) {
    String time = _logFormat.format(date);

    if(msg == null) {
      tag = "";
      msg = tag;
    } else {
      tag = "[$tag] ";
      msg = "$msg";
    }

    String sType = ("[" + level.label + "]").padRight(8);

    final str = "[$time] $sType $tag$msg";
    final color = _enum2color(level).toAnsi();

    
    final sb = new StringBuffer();
    for(String s in str.split("\n"))
      sb.write(color + s + "\n");
    print(sb.toString());
  }


  static EAnsiColor _enum2color(ELogLevel level) {
    if(level == ELogLevel.INFO)
        return EAnsiColor.BRIGHT_BLUE;
    else if(level == ELogLevel.DEBUG)
        return EAnsiColor.BRIGHT_MAGENTA;
    else if(level == ELogLevel.WARN)
        return EAnsiColor.BRIGHT_YELLOW;
    else if(level == ELogLevel.ERROR)
        return EAnsiColor.BRIGHT_RED;
    else if(level == ELogLevel.ASSERT)
        return EAnsiColor.GREEN;
    return EAnsiColor.WHITE;
  }
}