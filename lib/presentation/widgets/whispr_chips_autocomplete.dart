import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/util/extensions.dart';

class WhisprChipsAutocomplete<T extends Object> extends StatefulWidget {
  const WhisprChipsAutocomplete({
    super.key,
    required this.title,
    required this.availableOptions,
    required this.createNewDisplayText,
    required this.selectedOptions,
    required this.onSelected,
    required this.onDeleted,
    required this.displayText,
    required this.optionValue,
    required this.onCreateNewChip,
    required this.defaultPlaceholderValue,
    this.showAllKey = '#',
    this.placeholder,
  });

  final String title;
  final String createNewDisplayText;
  final String? placeholder;

  /// Key to show all available options.
  /// Default to `#`
  final String? showAllKey;
  final List<T> availableOptions;
  final List<T> selectedOptions;

  /// Default placeholder value to show `create new tag` when no tag
  /// is found.
  final T defaultPlaceholderValue;
  final Function(T) onSelected;
  final Function(T) onDeleted;
  final Function(String) onCreateNewChip;

  /// Value to be shown for each tag.
  final String Function(T) displayText;

  /// Value to be compared for filtering tags.
  final String Function(T) optionValue;

  @override
  State<WhisprChipsAutocomplete<T>> createState() =>
      _WhisprChipsAutocompleteState<T>();
}

class _WhisprChipsAutocompleteState<T extends Object>
    extends State<WhisprChipsAutocomplete<T>> {
  final TextEditingController _controller = TextEditingController();
  var _currentIsPlaceholder = false;
  final _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: GradientBoxBorder(
          gradient: WhisprGradient.mediumPurplePaleVioletGradient,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: WhisprTextStyles.bodyM.copyWith(
                color: WhisprColors.spanishViolet, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: widget.selectedOptions.isNotEmpty ? 4 : 0),
          Wrap(
            direction: Axis.horizontal,
            spacing: 4.0,
            runSpacing: 8.0,
            children: widget.selectedOptions
                .map((option) => WhisprAutoCompleteChips<T>(
                      option: option,
                      displayText: widget.displayText,
                      onDeleted: widget.onDeleted,
                    ))
                .toList(),
          ),
          SizedBox(height: widget.selectedOptions.isNotEmpty ? 4 : 0),
          RawAutocomplete<T>(
            textEditingController: _controller,
            focusNode: _focusNode,
            optionsBuilder: (value) {
              _currentIsPlaceholder = false;
              var currentString = value.text;
              // If empty text, dont show anything.
              if (currentString.isEmpty) {
                return [];
              }

              final selectedValues = List<String>.from(
                  widget.selectedOptions.map((x) => widget.optionValue(x)));
              final unselectedOptions = List<T>.from(widget.availableOptions
                  .where(
                      (x) => !selectedValues.contains(widget.optionValue(x))));

              // If show all key is defined and currently in text field,
              // show all available options.
              if (widget.showAllKey != null &&
                  currentString.equalsIgnoreCase(widget.showAllKey!)) {
                return unselectedOptions;
              }

              if (widget.showAllKey != null &&
                  currentString.startsWith(widget.showAllKey!)) {
                currentString =
                    currentString.substring(widget.showAllKey!.length);
              }

              // Filter available options based on keyword input.
              final filtered = unselectedOptions.where((opt) => widget
                  .optionValue(opt)
                  .toLowerCase()
                  .contains(currentString.toLowerCase()));

              if (filtered.isEmpty) {
                _currentIsPlaceholder = true;
                return [widget.defaultPlaceholderValue];
              } else {
                return filtered;
              }
            },
            onSelected: _onChipSelected,
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                enableSuggestions: false,
                autocorrect: false,
                onFieldSubmitted: (value) {
                  // Handle manually if the current options
                  // is create new chip.
                  if (_currentIsPlaceholder) {
                    _onCreateNewChip(value);
                    return;
                  }

                  onFieldSubmitted();
                },
                style: WhisprTextStyles.subtitle1
                    .copyWith(color: WhisprColors.spanishViolet),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: widget.placeholder,
                  hintStyle: WhisprTextStyles.subtitle1.copyWith(
                      color: WhisprColors.spanishViolet.withValues(alpha: 0.5)),
                ),
              );
            },
            displayStringForOption: widget.displayText,
            optionsViewBuilder: (context, onSelected, options) {
              final shouldDefineHeight = options.length > 5;
              return Material(
                elevation: 4,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: shouldDefineHeight ? 150 : null,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: !shouldDefineHeight,
                    primary: false,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final T option = options.elementAt(index);
                      final isFirstItem = index == 0;
                      final isLastItem = index == options.length - 1;
                      final topBorderRadius = isFirstItem ? 10.0 : 0.0;
                      final bottomBorderRadius = isLastItem ? 10.0 : 0.0;
                      final isPlaceholder = options.length == 1 &&
                          options.first == widget.defaultPlaceholderValue;
                      return InkWell(
                        key: GlobalObjectKey(option),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(topBorderRadius),
                          bottom: Radius.circular(bottomBorderRadius),
                        ),
                        onTap: () {
                          isPlaceholder
                              ? _onCreateNewChip(_controller.text)
                              : _onChipSelected(option);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            spacing: 4,
                            children: [
                              isPlaceholder
                                  ? Icon(
                                      Icons.add_rounded,
                                      color: WhisprColors.spanishViolet,
                                      size: 16,
                                    )
                                  : SizedBox(),
                              Text(
                                isPlaceholder
                                    ? widget.createNewDisplayText
                                    : widget.displayText(option),
                                style: WhisprTextStyles.subtitle1.copyWith(
                                    color: WhisprColors.spanishViolet),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onCreateNewChip(String value) {
    var currentValue = value;

    // If current text starts with prefix, remove the prefix before saving.
    if (widget.showAllKey != null &&
        currentValue.startsWith(widget.showAllKey!)) {
      currentValue = currentValue.substring(widget.showAllKey!.length);
    }

    _controller.value = TextEditingValue.empty;
    widget.onCreateNewChip(currentValue);
  }

  void _onChipSelected(T option) {
    _controller.value = TextEditingValue.empty;

    // If the current selected is defaultOptions, don't call onSelected.
    if (option == widget.defaultPlaceholderValue) {
      return;
    }

    widget.onSelected(option);
  }
}

class WhisprAutoCompleteChips<T> extends StatelessWidget {
  const WhisprAutoCompleteChips({
    super.key,
    required this.option,
    required this.displayText,
    required this.onDeleted,
  });

  final T option;
  final String Function(T) displayText;
  final Function(T) onDeleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: WhisprGradient.magnoliaSoapGradient,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            displayText(option),
            style: WhisprTextStyles.subtitle1.copyWith(
              height: 1,
              color: WhisprColors.spanishViolet,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 4),
          SizedBox(
            width: 12,
            height: 12,
            child: IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: () => onDeleted(option),
              icon: const Icon(
                Icons.close_rounded,
                size: 12,
              ),
              color: WhisprColors.spanishViolet,
            ),
          ),
        ],
      ),
    );
  }
}
