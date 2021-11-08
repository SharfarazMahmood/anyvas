class HttpRequest implements Exception {
  static Map<String, String> headers = {
    'NST':
        'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJOU1RfS0VZIjoidGVzdGFwaTEyM3Nha2hhdyJ9.l9txvKvpCrPsW78C9CFfUEVBbZcPpC7kBESRWBUthWjBG6dfP0YgrtoNKoe-PHExT_LGzYXoT1vvxGzWKxDGMA',
    'Tocken':
        'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJOU1RfS0VZIjoidGVzdGFwaTEyM3Nha2hhdyJ9.ca-7lHYgFnU_LXR_Q6_j3pIVb8oAkbn7kDonJn_4SepPhewJ6AHJyLUoITkAsIeOhakoePZ1bjq1rAb3f0GwrQ',
    'DeviceId': 'DeviceId',
    'Content-Type': 'application/json',
  };
  static final loginErrorList = [
    "No customer account found",
    "The credentials provided are incorrect",
  ];
  static final signupErrorList = [
    "this email is linked to another account, please enter another number",
  ];
  final String message;

  HttpRequest(this.message);

  @override
  String toString() {
    return message;
    // return super.toString();
  }
}
