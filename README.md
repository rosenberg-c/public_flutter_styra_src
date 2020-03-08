# flutter_styra

You need to setup a Firebase account.
Add google-servive.json to android/app if you have an android device

Add  GoogleService-info.plist to ios/Runner if you have iOS device

# Linter
https://github.com/dart-lang/sdk/issues/37913
dartanalyzer --enable-experiment extension-methods --options analysis_options.yaml .


# Locale
## On Ios you must add to Info.plist

Localizations [English, sv]

$(DEVELOPMENT_LANGUAGE)

```
python lib/app_locale/scripts/generateLocale.py
```

