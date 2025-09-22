import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/util/extensions.dart';

class WhisprTextField extends StatefulWidget {
  ///
  /// Generic Atlas Text Field
  ///
  /// Usage: This text field can represent an
  /// * Password text field by setting [isPassword] to [true].
  /// * Icon text field by setting either or both [leadingIcon] and [trailingIcon]
  /// * Expanded text field by setting [expands] and [minLines]
  ///
  /// To disable the text field completely, set [isEditable] to [false].
  /// The [readonly] field allows the text field to be clicked and focused, and it allows the
  /// trailing icon to be tapped if [trailingIconOnTap] is provided.
  ///
  const WhisprTextField({
    super.key,
    required this.whisprTextFieldStyle,
    this.title,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixText,
    this.errorMaxLines = 1,
    this.isEditable = true,
    this.isReadOnly = false,
    this.expands = false,
    this.minLines,
    this.maxLines,
    this.onTextChanged,
    this.onSubmitted,
    this.leadingIcon,
    this.trailingIcon,
    this.trailingIconOnTap,
    this.controller,
    this.isPassword = false,
    this.enableSuggestions = true,
    this.autoCorrect = true,
    this.maxLength,
    this.onSaved,
    this.onTap,
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.textInputType,
    this.inputFormatters,
  });

  final String? title;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? prefixText;
  final int? errorMaxLines;
  final bool isEditable;
  final bool isReadOnly;
  final bool expands;
  final bool isPassword;
  final bool enableSuggestions;
  final bool autoCorrect;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final ValueSetter<String>? onTextChanged;
  final ValueSetter<String>? onSubmitted;
  final ValueSetter<String?>? onSaved;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final IconData? trailingIcon;
  final VoidCallback? trailingIconOnTap;
  final IconData? leadingIcon;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final WhisprTextFieldStyle whisprTextFieldStyle;

  @override
  State<WhisprTextField> createState() => _WhisprTextFieldState();
}

class _WhisprTextFieldState extends State<WhisprTextField> {
  final FocusNode _focusNode = FocusNode();
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();

  bool _showPassword = false;
  String? _validatorErrorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
    _controller.addListener(() => setState(() {
          _validate();
        }));
  }

  @override
  void didUpdateWidget(covariant WhisprTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if parent swaps controllers, rewire listeners
    if (oldWidget.controller != widget.controller &&
        widget.controller != null) {
      _controller.removeListener(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.controller == null) _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: _resolveDecoration(),
          child: TextFormField(
            focusNode: _focusNode,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            decoration: _buildInputDecoration(context),
            enabled: widget.isEditable,
            readOnly: widget.isReadOnly,
            expands: widget.expands,
            obscureText: widget.isPassword && !_showPassword,
            enableSuggestions:
                widget.isPassword ? false : widget.enableSuggestions,
            autocorrect: widget.isPassword ? false : widget.autoCorrect,
            onChanged: widget.onTextChanged,
            onFieldSubmitted: widget.onSubmitted,
            onTap: widget.onTap,
            onSaved: widget.onSaved,
            controller: _controller,
            textInputAction: widget.textInputAction,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            keyboardType: widget.textInputType,
            inputFormatters: widget.inputFormatters,
            validator: (value) {
              final err = widget.validator?.call(value);
              setState(() => _validatorErrorText = err);
              return err;
            },
            // Disable built-in error text.
            errorBuilder: (_, error) => SizedBox(),
            // Disable built-in text counter.
            buildCounter: (BuildContext context,
                {int? currentLength, int? maxLength, bool? isFocused}) {
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 4, 14, 0),
          child: Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _resolveErrorOrHelperText()),
              _resolveTextFieldCounter(),
            ],
          ),
        )
      ],
    );
  }

  void _validate() {
    if (widget.validator != null) {
      _validatorErrorText = widget.validator!(_controller.text);
    }
  }

  bool get _isError =>
      widget.errorText.isNotNullOrEmpty || _validatorErrorText.isNotNullOrEmpty;

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      label: widget.title != null
          ? Text(
              widget.title!,
              style: WhisprTextStyles.bodyL.copyWith(
                color: _resolveTitleColor(),
              ),
            )
          : null,
      hintText: widget.hint,
      suffixIcon: _resolveSuffixIcon(),
      prefixIcon: widget.leadingIcon != null ? Icon(widget.leadingIcon) : null,
      fillColor: Colors.transparent,
      filled: true,
      prefixText: widget.prefixText,
      prefixStyle: WhisprTextStyles.bodyL.copyWith(
        color: widget.isEditable ? null : WhisprColors.spanishGray,
      ),
      border: _resolveBorder(),
      // Set to default color for disabled icon color.
      prefixIconColor: widget.isEditable ? WhisprColors.mediumPurple : null,
      suffixIconColor: widget.isEditable ? WhisprColors.mediumPurple : null,
      focusedErrorBorder: _resolveErrorBorder(),
    );
  }

  InputBorder? _resolveErrorBorder() => switch (widget.whisprTextFieldStyle) {
        WhisprTextFieldStyle.outlined => null,
        WhisprTextFieldStyle.underlined => UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
      };

  InputBorder? _resolveBorder() {
    return switch (widget.whisprTextFieldStyle) {
      WhisprTextFieldStyle.outlined => InputBorder.none,
      WhisprTextFieldStyle.underlined =>
        UnderlineInputBorder(borderSide: _resolveUnderlinedBorderSide()),
    };
  }

  BorderSide _resolveUnderlinedBorderSide() {
    if (_focusNode.hasFocus) {
      return BorderSide();
    } else {
      return BorderSide.none;
    }
  }

  Widget? _resolveSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _showPassword
              ? Icons.visibility_off_rounded
              : Icons.visibility_rounded,
        ),
        onPressed: () {
          setState(() {
            _showPassword = !_showPassword;
          });
        },
      );
    } else if (widget.trailingIcon != null) {
      return IconButton(
        icon: Icon(widget.trailingIcon),
        onPressed: widget.trailingIconOnTap,
      );
    } else {
      return null;
    }
  }

  Widget _resolveErrorOrHelperText() {
    if (_isError) {
      return Text(
        _validatorErrorText ?? widget.errorText!,
        maxLines: widget.errorMaxLines,
        style: WhisprTextStyles.bodyS.copyWith(
          color: WhisprColors.crayola,
        ),
      );
    }

    if (widget.helperText.isNotNullOrEmpty) {
      return Text(
        widget.helperText!,
        style: WhisprTextStyles.bodyS,
      );
    }

    return SizedBox();
  }

  Widget _resolveTextFieldCounter() {
    if (widget.maxLength != null && _focusNode.hasFocus) {
      return Text(
        '${_controller.text.characters.length}/${widget.maxLength}',
        maxLines: 1,
        style: WhisprTextStyles.bodyS,
      );
    }

    return SizedBox();
  }

  Color? _resolveTitleColor() {
    if (_isError) {
      return WhisprColors.crayola;
    }

    if (widget.isEditable && !widget.isReadOnly) {
      return WhisprColors.spanishViolet;
    } else {
      return null;
    }
  }

  Color _resolveFillColor() => switch (widget.whisprTextFieldStyle) {
        WhisprTextFieldStyle.outlined => WhisprColors.antiFlashWhite,
        WhisprTextFieldStyle.underlined => Colors.transparent,
      };

  Decoration? _resolveDecoration() => switch (widget.whisprTextFieldStyle) {
        WhisprTextFieldStyle.outlined => BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: _resolveDecorationBorder(),
            color: _resolveFillColor(),
            boxShadow: _focusNode.hasFocus
                ? [
                    _isError
                        ? BoxShadow(
                            color: WhisprColors.crayola.withValues(alpha: 0.5),
                            blurRadius: 15,
                            spreadRadius: 1,
                          )
                        : BoxShadow(
                            color: WhisprColors.mauve.withValues(alpha: 0.5),
                            blurRadius: 15,
                            spreadRadius: 1,
                          )
                  ]
                : null,
          ),
        WhisprTextFieldStyle.underlined => null,
      };

  BoxBorder? _resolveDecorationBorder() {
    if (_isError) {
      return Border.all(width: 2, color: WhisprColors.crayola);
    }

    if (!widget.isEditable || widget.isReadOnly) {
      return Border.all(width: 2, color: WhisprColors.silverChalice);
    }

    return GradientBoxBorder(
      gradient: WhisprGradient.mediumPurplePaleVioletGradient,
      width: 2,
    );
  }
}

enum WhisprTextFieldStyle { outlined, underlined }
