class HttpException implements Exception {
  static final errorList = [
    "No customer account found",
    "The credentials provided are incorrect",
  ];
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
    // return super.toString();
  }
}
