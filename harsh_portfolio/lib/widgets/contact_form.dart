import 'package:flutter/material.dart';
import '../models/contact_request.dart';
import '../services/emailjs_service.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  final _honeypotController = TextEditingController();

  SendStatus _status = SendStatus.idle;
  DateTime? _lastSubmission;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    _honeypotController.dispose();
    super.dispose();
  }

  bool get _isDuplicateSubmission {
    if (_lastSubmission == null) return false;
    return DateTime.now().difference(_lastSubmission!).inSeconds < 30;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_honeypotController.text.isNotEmpty) return;
    if (_isDuplicateSubmission) {
      _showSnackBar('Please wait before submitting again.', isError: true);
      return;
    }

    setState(() => _status = SendStatus.sending);

    final request = ContactRequest(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      message: _messageController.text.trim(),
      submittedAt: DateTime.now().toUtc().toIso8601String(),
    );

    final success = await EmailJsService.sendEmail(request);

    if (!mounted) return;

    if (success) {
      setState(() {
        _status = SendStatus.success;
        _lastSubmission = DateTime.now();
      });
      _showSnackBar('Message sent successfully!', isError: false);
      _formKey.currentState!.reset();
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _messageController.clear();
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _status = SendStatus.idle);
      });
    } else {
      setState(() => _status = SendStatus.failed);
      _showSnackBar('Failed to send. Please try again.', isError: true);
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _status = SendStatus.idle);
      });
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) return 'Message is required';
    if (value.trim().length < 10) return 'Message must be at least 10 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSending = _status == SendStatus.sending;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Honeypot field (hidden from users, catches bots)
          Opacity(
            opacity: 0,
            child: SizedBox(
              height: 0,
              child: TextFormField(
                controller: _honeypotController,
                decoration: const InputDecoration(labelText: 'Website'),
              ),
            ),
          ),
          _buildField(
            controller: _nameController,
            label: 'Name',
            hint: 'Your full name',
            icon: Icons.person_outline_rounded,
            validator: _validateName,
            enabled: !isSending,
          ),
          const SizedBox(height: 16),
          _buildField(
            controller: _emailController,
            label: 'Email',
            hint: 'your@email.com',
            icon: Icons.email_outlined,
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
            enabled: !isSending,
          ),
          const SizedBox(height: 16),
          _buildField(
            controller: _phoneController,
            label: 'Phone (optional)',
            hint: '+91 XXXXX XXXXX',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            enabled: !isSending,
          ),
          const SizedBox(height: 16),
          _buildField(
            controller: _messageController,
            label: 'Message',
            hint: 'Tell me about your project or inquiry...',
            icon: Icons.message_outlined,
            validator: _validateMessage,
            maxLines: 5,
            enabled: !isSending,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: isSending ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: _buttonColor(theme),
                foregroundColor: Colors.white,
                disabledBackgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.5),
                disabledForegroundColor: Colors.white70,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _buttonChild(),
            ),
          ),
        ],
      ),
    );
  }

  Color _buttonColor(ThemeData theme) {
    switch (_status) {
      case SendStatus.success:
        return Colors.green.shade600;
      case SendStatus.failed:
        return Colors.red.shade600;
      default:
        return theme.colorScheme.secondary;
    }
  }

  Widget _buttonChild() {
    switch (_status) {
      case SendStatus.sending:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
            Text('Sending...', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        );
      case SendStatus.success:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_rounded, size: 18),
            SizedBox(width: 8),
            Text('Sent Successfully', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        );
      case SendStatus.failed:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, size: 18),
            SizedBox(width: 8),
            Text('Failed – Retry', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        );
      default:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.send_rounded, size: 18),
            SizedBox(width: 8),
            Text('Send Message', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        );
    }
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      enabled: enabled,
      style: TextStyle(
        fontSize: 14,
        color: theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 20),
        filled: true,
        fillColor: theme.colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: theme.dividerColor.withValues(alpha: 0.2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: theme.dividerColor.withValues(alpha: 0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: theme.colorScheme.secondary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(
          fontSize: 13,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        hintStyle: TextStyle(
          fontSize: 13,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
