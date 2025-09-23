import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../components/buttons/primary_button.dart';
import '../components/inputs/input_email.dart';
import '../l10n/app_localizations.dart';

/// PasswordRequestScreen - Screen for requesting password reset
/// 
/// Simple screen that allows users to enter their email address
/// to receive password reset instructions.
class PasswordRequestScreen extends StatefulWidget {
  const PasswordRequestScreen({super.key});

  @override
  State<PasswordRequestScreen> createState() => _PasswordRequestScreenState();
}

class _PasswordRequestScreenState extends State<PasswordRequestScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  bool _isEmailValid = false;

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    
    // Initial validation check
    _validateInitialState();
    
    // Fix für Simulator: Auto-Focus auf Email-Feld nach Screen-Aufbau
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Kleine Verzögerung für bessere Simulator-Kompatibilität
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            _emailFocus.requestFocus();
          }
        });
      }
    });
  }

  void _validateInitialState() {
    // Beim Start ist das Feld leer, also Button deaktiviert
    setState(() {
      _isEmailValid = _emailController.text.isNotEmpty && 
                     _emailController.text.contains('@') && 
                     _emailController.text.contains('.');
    });
  }

  Future<void> _handlePasswordRequest() async {
    if (!_isEmailValid) return;

    // Simulate API call for password reset
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.passwordRequestSent),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );

      // Navigate back to login
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.passwordRequest)),
      body: GestureDetector(
        // Fix für Simulator: Tastatur-Eingabe aktivieren
        onTap: () {
          FocusScope.of(context).requestFocus(_emailFocus);
        },
        child: FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(AppLocalizations.of(context)!.passwordRequestDescription),
                const SizedBox(height: 20),
                FocusTraversalOrder(
                  order: const NumericFocusOrder(1),
                  child: CallbackShortcuts(
                    bindings: {
                      const SingleActivator(LogicalKeyboardKey.tab): () {
                        // Bei nur einem Feld: Tab springt zum Submit-Button
                        _handlePasswordRequest();
                      },
                    },
                    child: InputEmail(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      onSubmitted: (_) => _handlePasswordRequest(),
                      onValidationChanged: (isValid) {
                        if (kDebugMode) {
                          print('Email validation changed: $isValid, text: "${_emailController.text}"');
                        }
                        setState(() {
                          _isEmailValid = isValid;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  label: AppLocalizations.of(context)!.sendPasswordRequest,
                  enabled: _isEmailValid,
                  onPressed: _isEmailValid ? _handlePasswordRequest : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}