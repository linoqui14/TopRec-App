

import 'package:flutter/material.dart';

import '../tools/variables.dart';



class CustomTextButton extends StatelessWidget{
  const CustomTextButton(
      {
        Key? key,
        this.onPressed,
        this.text="Text Here",
        this.rTR=10,this.rTl=10,
        this.rBR=10,this.rBL=10,
        this.color=MyColors.skyBlueDead,
        this.width = 100,
        this.height = 30,
        this.padding = EdgeInsets.zero,
        this.onHold,
        this.radiusAll
      }) : super(key: key);

  final Function()? onPressed;
  final String text;
  final double rTl,rTR,rBL,rBR;
  final Color color;
  final double width;
  final double height;
  final EdgeInsets padding;
  final Function()? onHold;
  final double? radiusAll;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton(
        onLongPress: onHold,
        onPressed: onPressed,
        child: Container(
            height: height,
            padding: padding,
            alignment: Alignment.center,
            width: width,
            child: Text(text,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
        ),
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            fixedSize: MaterialStateProperty.all(Size(width, height)),
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:radiusAll!=null? BorderRadius.all(Radius.circular(radiusAll!)):BorderRadius.only(
                    bottomLeft: Radius.circular(rBL),
                    bottomRight:  Radius.circular(rBR),
                    topLeft: Radius.circular(rTl),
                    topRight:  Radius.circular(rTR),

                  ),

                )
            )
        )
    );
  }
}