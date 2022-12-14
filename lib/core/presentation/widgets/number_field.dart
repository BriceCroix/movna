import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Thanks to this article for this helper widget :
/// https://www.flutterclutter.dev/flutter/tutorials/how-to-create-a-number-input/2021/86522/
class NumberField extends StatelessWidget {
  const NumberField({
    super.key,
    this.controller,
    this.value,
    this.onChanged,
    this.onSubmitted,
    this.allowDecimal = false,
    this.decoration,
  });

  final TextEditingController? controller;
  final String? value;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool allowDecimal;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: TextInputType.numberWithOptions(decimal: allowDecimal),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(_getRegexString())),
        TextInputFormatter.withFunction(
          (oldValue, newValue) => newValue.copyWith(
            text: newValue.text.replaceAll(',', '.'),
          ),
        ),
      ],
      decoration: decoration,
    );
  }

  String _getRegexString() =>
      //allowDecimal ? r'[0-9]+[,.]{0,1}[0-9]*' : r'[0-9]';
      allowDecimal ? r'[0-9]+[,.]{0,1}[0-9]*' : r'[0-9]';
}
