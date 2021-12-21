import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomText extends StatelessWidget {
  final String ?text;
  final double ?size;
  final Color ?color;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final int? mxlines;
  final TextOverflow? textOverflow;

  final FontWeight ?weight;
   CustomText({ @required this.text, this.size, this.color,this.weight,this.textAlign,this.textDirection,this.mxlines,this.textOverflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,style: GoogleFonts.poppins(fontSize: size?? 16,color: color ?? Colors.black,fontWeight: weight ?? FontWeight.normal),
       maxLines: mxlines,
      overflow: textOverflow,
       textDirection: textDirection,
      // textAlign: TextAlign.center,
    );
  }
}
