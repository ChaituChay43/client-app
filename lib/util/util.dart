import 'dart:convert';

import 'package:crypto/crypto.dart';

String maskEmail(String email) {
  if (email.isEmpty || !email.contains('@')) {
    return email; // Return original if it's not a valid email
  }

  List<String> parts = email.split('@');
  String name = parts[0];
  String domain = parts[1];

  // Mask the name part
  String maskedName;
  if (name.length <= 2) {
    maskedName = '*' * name.length;
  } else {
    maskedName = name[0] + '*' * (name.length - 2) + name[name.length - 1];
  }

  // Mask the domain (optional, remove if you want to keep domain visible)
  List<String> domainParts = domain.split('.');
  String maskedDomain = domainParts[0][0] + '*' * (domainParts[0].length - 1);

  return '$maskedName@$maskedDomain.${domainParts[1]}';
}

String calculateSHA256(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
