import 'package:dropdown_button2/dropdown_button2.dart';

import 'form_field_controller.dart';
import 'package:flutter/material.dart';

class FlutterDropDown<T> extends StatefulWidget {
  const FlutterDropDown({
    Key? key,
    required this.controller,
    this.hintText,
    this.searchHintText,
    required this.options,
    this.optionLabels,
    this.onChanged,
    this.onChangedForMultiSelect,
    this.icon,
    this.width,
    this.height,
    this.maxHeight,
    this.fillColor,
    this.searchHintTextStyle,
    this.searchCursorColor,
    required this.textStyle,
    required this.elevation,
    required this.borderWidth,
    required this.borderRadius,
    required this.borderColor,
    required this.margin,
    this.hidesUnderline = false,
    this.disabled = false,
    this.isOverButton = false,
    this.isSearchable = false,
    this.isMultiSelect = false,
  }) : super(key: key);

  final FormFieldController<T> controller;
  final String? hintText;
  final String? searchHintText;
  final List<T> options;
  final List<String>? optionLabels;
  final Function(T?)? onChanged;
  final Function(List<T>?)? onChangedForMultiSelect;
  final Widget? icon;
  final double? width;
  final double? height;
  final double? maxHeight;
  final Color? fillColor;
  final TextStyle? searchHintTextStyle;
  final Color? searchCursorColor;
  final TextStyle textStyle;
  final double elevation;
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsetsGeometry margin;
  final bool hidesUnderline;
  final bool disabled;
  final bool isOverButton;
  final bool isSearchable;
  final bool isMultiSelect;

  @override
  State<FlutterDropDown<T>> createState() => _FlutterDropDownState<T>();
}

class _FlutterDropDownState<T> extends State<FlutterDropDown<T>> {
  final TextEditingController _textEditingController = TextEditingController();

  void Function() get listener => widget.isMultiSelect
      ? () {}
      : () => widget.onChanged!(widget.controller.value);

  @override
  void initState() {
    widget.controller.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }

  List<T> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    final optionToDisplayValue = Map.fromEntries(
      widget.options.asMap().entries.map((option) => MapEntry(
          option.value,
          widget.optionLabels == null ||
                  widget.optionLabels!.length < option.key + 1
              ? option.value.toString()
              : widget.optionLabels![option.key])),
    );
    final value = widget.options.contains(widget.controller.value)
        ? widget.controller.value
        : null;
    final items = widget.options
        .map(
          (option) => DropdownMenuItem<T>(
            value: option,
            child: Text(
              optionToDisplayValue[option] ?? '',
              style: widget.textStyle,
            ),
          ),
        )
        .toList();
    final hintText = widget.hintText != null
        ? Text(widget.hintText!, style: widget.textStyle)
        : null;
    void Function(T?)? onChanged = widget.disabled || widget.isMultiSelect
        ? null
        : (value) => widget.controller.value = value;
    final dropdownWidget = _useDropdown2()
        ? _buildDropdown(
            value,
            items,
            onChanged,
            hintText,
            optionToDisplayValue,
            widget.isSearchable,
            widget.disabled,
            widget.isMultiSelect,
            widget.onChangedForMultiSelect,
          )
        : _buildLegacyDropdown(value, items, onChanged, hintText);
    final childWidget = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
        color: widget.fillColor,
      ),
      child: Padding(
        padding: widget.margin,
        child: widget.hidesUnderline
            ? DropdownButtonHideUnderline(child: dropdownWidget)
            : dropdownWidget,
      ),
    );
    if (widget.height != null || widget.width != null) {
      return Container(
        width: widget.width,
        height: widget.height,
        child: childWidget,
      );
    }
    return childWidget;
  }

  Widget _buildLegacyDropdown(
    T? value,
    List<DropdownMenuItem<T>>? items,
    void Function(T?)? onChanged,
    Text? hintText,
  ) {
    return DropdownButton<T>(
      value: value,
      hint: hintText,
      items: items,
      elevation: widget.elevation.toInt(),
      onChanged: onChanged,
      icon: widget.icon,
      isExpanded: true,
      dropdownColor: widget.fillColor,
      focusColor: Colors.transparent,
    );
  }

  Widget _buildDropdown(
    T? value,
    List<DropdownMenuItem<T>>? items,
    void Function(T?)? onChanged,
    Text? hintText,
    Map<T, String> optionLabels,
    bool isSearchable,
    bool disabled,
    bool isMultiSelect,
    Function(List<T>?)? onChangedForMultiSelect,
  ) {
    final overlayColor = MaterialStateProperty.resolveWith<Color?>((states) =>
        states.contains(MaterialState.focused) ? Colors.transparent : null);
    final iconStyleData = widget.icon != null
        ? IconStyleData(icon: widget.icon!)
        : const IconStyleData();
    return DropdownButton2<T>(
      value: isMultiSelect
          ? selectedItems.isEmpty
              ? null
              : selectedItems.last
          : value,
      hint: hintText,
      items: isMultiSelect
          ? widget.options.map((item) {
              return DropdownMenuItem(
                value: item,
                // Disable default onTap to avoid closing menu when selecting an item
                enabled: false,
                child: StatefulBuilder(
                  builder: (context, menuSetState) {
                    final isSelected = selectedItems.contains(item);
                    return InkWell(
                      onTap: () {
                        isSelected
                            ? selectedItems.remove(item)
                            : selectedItems.add(item);
                        onChangedForMultiSelect!(selectedItems);
                        //This rebuilds the StatefulWidget to update the button's text
                        setState(() {});
                        //This rebuilds the dropdownMenu Widget to update the check mark
                        menuSetState(() {});
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            if (isSelected)
                              const Icon(Icons.check_box_outlined)
                            else
                              const Icon(Icons.check_box_outline_blank),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                item as String,
                                style: widget.textStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList()
          : items,
      iconStyleData: iconStyleData,
      buttonStyleData: ButtonStyleData(
        elevation: widget.elevation.toInt(),
        overlayColor: overlayColor,
      ),
      menuItemStyleData: MenuItemStyleData(overlayColor: overlayColor),
      dropdownStyleData: DropdownStyleData(
        elevation: widget.elevation!.toInt(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: widget.fillColor,
        ),
        isOverButton: widget.isOverButton,
        maxHeight: widget.maxHeight,
      ),
      // onChanged is handled by the onChangedForMultiSelect function
      onChanged: isMultiSelect
          ? disabled
              ? null
              : (val) {}
          : onChanged,
      isExpanded: true,
      selectedItemBuilder: isMultiSelect
          ? (context) {
              return widget.options.map(
                (item) {
                  return Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      selectedItems.join(', '),
                      style: const TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  );
                },
              ).toList();
            }
          : null,
      dropdownSearchData: isSearchable
          ? DropdownSearchData<T>(
              searchController: _textEditingController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: _textEditingController,
                  cursorColor: widget.searchCursorColor,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: widget.searchHintText,
                    hintStyle: widget.searchHintTextStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return (optionLabels[item.value] ?? '')
                    .toLowerCase()
                    .contains(searchValue.toLowerCase());
              },
            )
          : null,
      // This to clear the search value when you close the menu
      onMenuStateChange: isSearchable
          ? (isOpen) {
              if (!isOpen) {
                _textEditingController.clear();
              }
            }
          : null,
    );
  }

  bool _useDropdown2() {
    return widget.isMultiSelect ||
        widget.isSearchable ||
        !widget.isOverButton ||
        widget.maxHeight != null;
  }
}
