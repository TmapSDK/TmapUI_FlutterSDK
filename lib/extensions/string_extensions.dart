part of extensions;

T? cast<T>(x) => x is T ? x : null;

extension StringConvert on String {
  bool? toBoolean() {
    print(this);
    if ((this.toLowerCase() == "true" || this.toLowerCase() == "1")) {
      return true;
    } else if (this.toLowerCase() == "false" || this.toLowerCase() == "0") {
      return false;
    } else {
      return null;
    }
  }
}