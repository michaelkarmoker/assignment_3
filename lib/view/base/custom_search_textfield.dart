

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../util/colors.dart';
import '../../util/styles.dart';

class CustomSearchTextField extends StatefulWidget {

  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final IconData? suffixIcon;
  final String? prefixIcon;
  final Function? onChanged;
  final Function? sufixIconFun;
  final Function? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final Color? color;
  final TextCapitalization capitalization;
  final Function? prefixIconFun;
  final bool divider;

  CustomSearchTextField(
      {this.hintText = 'Search',
        required this.controller,
        required this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
         this.onSubmit,
        this.onChanged,
        this.suffixIcon,
        this.prefixIcon,
        this.sufixIconFun,
        this.prefixIconFun,
        this.color,
        this.capitalization = TextCapitalization.none,
        this.isPassword = false,
        this.divider = false, }
      );

  @override
  _CustomSearchTextFieldState createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric( vertical: 5),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color(0xff888A8F))
      ),
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 0),
        child: TextField(
          textInputAction: TextInputAction.search,
          textAlignVertical: TextAlignVertical.center,
          maxLines: widget.maxLines,
          minLines: 1,
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: robotoRegular.copyWith(fontSize: 14,color:widget.color!=null?widget.color:null),
          // textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          cursorColor: textColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: false,
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9]'))] : null,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top:10,bottom:10,left: 5),
           /* border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
             // borderSide: BorderSide(style: BorderStyle.none, width: 0.5),
            ),*/
            isDense: true,
            hintText: widget.hintText,
            fillColor: bgColor,
            hintStyle: robotoRegular.copyWith(fontSize: 14, color: textColor),
            filled: true,
            prefixIcon: widget.prefixIcon != null ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset(widget.prefixIcon!, height: 15, width: 15,),
            ) : null,
            suffixIcon:  widget.suffixIcon!=null? IconButton(
              icon: Icon(widget.suffixIcon!, color: Colors.white.withOpacity(0.6),size: 20,),
              onPressed:()=> widget.sufixIconFun!=null?widget.sufixIconFun!():null,
            ):null
          ),
          onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
              : widget.onSubmit != null ? widget.onSubmit!(text) : null,
          onChanged:(text)=> widget.onChanged!=null?widget.onChanged!(text):widget.onChanged,
        ),
      ),
    );
  }



}
