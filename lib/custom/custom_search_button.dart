import 'package:flutter/material.dart';
import 'package:machine_test/screens/search_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'custom_text.dart';
class CustomSearchButton extends StatelessWidget {
  const CustomSearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: (){
          Navigator.push(context, PageTransition(child: ProductSearchPage(), type: PageTransitionType.rightToLeft));
        },
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(15),color: Colors.white),
          height: 30,
          width: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_rounded,size: 20,),
              Center(
                child: CustomText(
                  text: " Search",
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
