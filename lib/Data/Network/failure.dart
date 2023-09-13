class Failure implements Exception {
  final int? code;
  final String? message;

  Failure({required this.code,required this.message});
}