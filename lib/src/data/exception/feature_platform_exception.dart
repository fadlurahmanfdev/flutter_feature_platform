import 'dart:io';

class FeaturePlatformException extends IOException {
  String code;
  String message;

  FeaturePlatformException({required this.code, required this.message});
}
