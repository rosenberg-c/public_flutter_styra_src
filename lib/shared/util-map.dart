T getKey<T>(Map<String, dynamic> map, String key, T response) {
  return map[key] ??
      () {
        print("Could not get key: $key");
        return response;
      }();
}
