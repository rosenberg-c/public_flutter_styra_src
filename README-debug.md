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

