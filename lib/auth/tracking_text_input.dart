import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teddy_sign_in/app/pages/auth/helper/input_helper.dart';

typedef CaretMoved = void Function(Offset globalCaretPosition);
typedef TextChanged = void Function(String text);

// Helper widget to track caret position.
class TrackingTextInput extends StatefulWidget {
  const TrackingTextInput({
    required this.enable,
    required this.label,
    required this.icon,
    this.onCaretMoved,
    this.onTextChanged,
    this.isObscured = false,
    Key? key,
  }) : super(key: key);
  final CaretMoved? onCaretMoved;
  final TextChanged? onTextChanged;

  final String label;
  final bool isObscured;
  final bool enable;

//  final FormFieldValidator<String> validator;
  final IconData icon;

  @override
  TrackingTextInputState createState() => TrackingTextInputState();
}

class TrackingTextInputState extends State<TrackingTextInput> {
  final GlobalKey _fieldKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  Timer? _debounceTimer;

//  bool _isPasswordField = false;
//  bool _passwordObscured = false;

  @override
  initState() {
    _textController.addListener(() {
      // We debounce the listener as sometimes the caret position is updated after the listener
      // this assures us we get an accurate caret position.
      if (_debounceTimer?.isActive ?? false) {
        _debounceTimer!.cancel();
      }
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        if (_fieldKey.currentContext != null) {
          // Find the render editable in the field.
          final RenderObject? fieldBox = _fieldKey.currentContext!.findRenderObject();
          Offset? caretPosition;
          if (fieldBox != null) {
            caretPosition = getCaretPosition(fieldBox as RenderBox);
          }

          if (widget.onCaretMoved != null) {
            if (caretPosition != null) {
              widget.onCaretMoved!(caretPosition);
            }
          }
        }
      });
      if (widget.onTextChanged != null) {
        widget.onTextChanged!(_textController.text);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _fieldKey,
      style: const TextStyle(fontSize: 16.0),
      enabled: widget.enable,
      keyboardType: widget.isObscured ? TextInputType.text : TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(fontSize: 16.0),
        prefixIcon: Icon(widget.icon),
      ),
      controller: _textController,
      obscureText: widget.isObscured,
    );
  }
}
