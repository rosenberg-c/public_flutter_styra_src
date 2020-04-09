T getKey<T>({Map<String, dynamic> map, String key, T defaultVal}) {
  return map[key] ??
          () {
        print("Could not get key: $key");
        return defaultVal;
      }();
}
