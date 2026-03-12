import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/helpers/app_color_helper.dart';
import 'package:flutter/material.dart';

class FChoiseChipe extends StatelessWidget {
  const FChoiseChipe({
    super.key, 
    required this.text, 
    required this.selected, 
    this.onSelected,
  });
final String text;
final bool selected;
final void Function(bool)? onSelected;
  @override
  Widget build(BuildContext context) {
    final isColor=AppColorHelper.getColor(text) !=null;
    return ChoiceChip(
      label:isColor?SizedBox() : Text(text),
     selected: selected,
     onSelected: onSelected,
    labelStyle: TextStyle(color: selected?Colors.white: null),
    avatar:isColor? CircularContainer(width: 50,height: 50,backgroundColor:AppColorHelper.getColor(text)!,):null,
    shape:isColor? CircleBorder():null,
    padding:isColor? EdgeInsets.all(0):null,
    labelPadding:isColor? EdgeInsets.all(0):null,
   selectedColor: isColor? Colors.green:null,
   backgroundColor:isColor? AppColorHelper.getColor(text)!:null,
     );
  }
}