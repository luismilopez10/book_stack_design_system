class ErrorModel {
  const ErrorModel({required this.message, this.code});
  final String message;
  final int? code;

  @override
  String toString() {
    return 'ErrorModel(message: $message, code: $code)';
  }
}
