import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class ReportCrashes {
  //record uncaught exceptions
  reportRecorderror(e, {bool fatal = false}) async {
    await FirebaseCrashlytics.instance
        .recordError(e, StackTrace.fromString(e), fatal: fatal);
  }

//set custom key
  reportErrorCustomKey(String key, String value) async {
    await FirebaseCrashlytics.instance.setCustomKey(key, value);
  }

//add log messages
  reportErrorLog(String message) async {
    await FirebaseCrashlytics.instance.log(message);
  }

//set user identifiers
  reportErrorSetUserIdentifiers(String identifier) async {
    await FirebaseCrashlytics.instance.setUserIdentifier(identifier);
  }

//perfrom crash
  performCrash() {
    FirebaseCrashlytics.instance.crash();
  }
}
