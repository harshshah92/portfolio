class ContactRequest {
  final String name;
  final String email;
  final String phone;
  final String message;
  final String submittedAt;
  final String source;

  const ContactRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
    required this.submittedAt,
    this.source = 'Portfolio Website',
  });

  Map<String, dynamic> toTemplateParams() {
    return {
      'name': name,
      'email': email,
      'phone': phone.isEmpty ? 'Not provided' : phone,
      'message': message,
      'submitted_at': submittedAt,
      'source': source,
    };
  }
}
