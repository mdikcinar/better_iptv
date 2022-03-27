import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../utils.dart';
import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool canBeEmpty;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  const CustomTextFormField({Key? key, this.label, this.hintText, this.validator, this.onSaved, this.canBeEmpty = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(left: Utils.normalPadding),
            child: CustomText.high(
              label! + (canBeEmpty ? '' : ' *'),
              textColor: getTextColor,
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Utils.lowRadius))),
            child: Padding(
              padding: EdgeInsets.all(Utils.normalPadding),
              child: TextFormField(
                maxLines: 1,
                validator: canBeEmpty
                    ? validator
                    : (value) {
                        if (value == null || value.isEmpty) {
                          return 'Can\'t be empty';
                        }
                        return validator != null ? validator!(value) : null;
                      },
                onSaved: onSaved,
                style: TextStyle(color: getTextColor),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(color: getTextColor.withOpacity(0.6)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
