import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/emailjs_config.dart';
import '../models/contact_request.dart';

enum SendStatus { idle, sending, success, failed }

class EmailJsService {
  static Future<bool> sendEmail(ContactRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(EmailJsConfig.apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': EmailJsConfig.serviceId,
          'template_id': EmailJsConfig.templateId,
          'user_id': EmailJsConfig.publicKey,
          'template_params': request.toTemplateParams(),
        }),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
