isValidIpNumber(String ip) {
  RegExp regExp = new RegExp(
    r"^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",
    caseSensitive: false,
    multiLine: false,
  );
  return regExp.hasMatch(ip);
}
