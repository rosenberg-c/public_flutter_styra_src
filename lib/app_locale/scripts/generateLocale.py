# noinspection PyInterpreter
"""
author: rosenberg-c

Generate messages

Usage:
python lib/localization/scripts/generateLocale.py
"""

import os


def join_path(path_a, path_b):
    return os.path.join(path_a, path_b)


def get_parent_dir(path):
    return os.path.split(path)[0]


def match_upper_end(name, matching_list):
    for item in matching_list:
        if name.upper().endswith(item.upper()):
            return True
    return False


def get_files_in_dir(path, match):
    _files = []
    for root, dirs, files in os.walk(path, topdown=True):
        for name in files:
            if match_upper_end(name=name, matching_list=match):
                _files.append(join_path(path_a=root, path_b=name))
    return _files


class FlutterTranslation:
    def __init__(self, locale_paths_, dart_files):
        self.locale_paths = locale_paths_
        self._dart_files = dart_files

        self._root_flutter_cmd = "flutter pub pub run intl_translation:"
        self._flutter_extract_cmd = self._root_flutter_cmd + "extract_to_arb --output-dir="
        self._flutter_generate_cmd = self._root_flutter_cmd + "generate_from_arb --output-dir="

    def _after_extract_to_arb(self):
        en_arb = os.path.join(self.locale_paths.arb_path, "intl_en.arb")
        messages_arb = os.path.join(self.locale_paths.arb_path, "intl_messages.arb")

        _rm = ["rm ", en_arb]
        _cp = ["cp ", messages_arb, " ", en_arb]
        os.system("".join(_rm))
        os.system("".join(_cp))

    def _add_files(self, cmd, root, files):
        for f in files:
            cmd.append(" " + os.path.join(root, f))
        return cmd

    def extract_to_arb(self):
        cmd = [self._flutter_extract_cmd, self.locale_paths.arb_path]
        cmd = self._add_files(cmd=cmd, root=self.locale_paths.rootPath, files=self._dart_files)

        os.system(''.join(cmd))

        self._after_extract_to_arb()

    def generate_from_arb(self):
        cmd = [self._flutter_generate_cmd, self.locale_paths.messages_path,
               " --no-use-deferred-loading"]
        cmd = self._add_files(cmd=cmd, root=self.locale_paths.rootPath, files=self._dart_files)
        cmd.append(" " + os.path.join(self.locale_paths.arb_path, "intl_*.arb"))

        os.system(''.join(cmd))


class LocalePaths:
    def __init__(self):
        self.path = "lib/app_locale"
        self.arb_path = os.path.abspath(os.path.join(self.path, "intl/arb"))
        self.messages_path = os.path.abspath(os.path.join(self.path, "intl/messages"))
        self.rootPath = os.path.abspath(os.path.join(self.path, "strings"))


if __name__ == '__main__':
    print("Generating locales..")
    locale_paths = LocalePaths()

    flutter_translations = FlutterTranslation(
        locale_paths_=locale_paths,
        dart_files=get_files_in_dir(path=locale_paths.rootPath, match=['.dart'])
    )

    if not os.path.isdir(locale_paths.arb_path):
        os.makedirs(locale_paths.arb_path)

    print("Extract to arb..")
    flutter_translations.extract_to_arb()

    if not os.path.isdir(locale_paths.messages_path):
        os.makedirs(locale_paths.messages_path)

    print("Generate from arb..")
    flutter_translations.generate_from_arb()
    print("Done.")
