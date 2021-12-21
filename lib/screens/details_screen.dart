import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/custom/custom_search_button.dart';
import 'package:machine_test/custom/custom_text.dart';
import 'package:machine_test/providers/provider_home.dart';
import 'package:machine_test/screens/search_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  String id;
   DetailsScreen({Key? key,required this.id}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initState
    Provider.of<ProviderHome>(context, listen: false).getDet(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    //https://dribbble.com/shots/7150763-Snack-shopping-App/attachments/155068?mode=media
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orangeAccent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){
                Navigator.of(context);
              }, icon: const Icon(Icons.arrow_back)),
              const CustomSearchButton()
            ],
        ),
          ),
        ),
        body: SingleChildScrollView(
          child: Consumer<ProviderHome>(builder: (context, data, child) {
            if (data.isDetloading == false) {
              var image = Uri.parse(
                  'https://admin.maaxkart.com/' '${data.Details?['image']}');
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image !=null?Image.network(
                    '${image}',
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ): CupertinoActivityIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: CustomText(
                      text: '${data.Details?['pro_name']}',
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: '${data.Details?['attribute']}',
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(
                          '\u{20B9}${data.Details?['selling_price']}',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 15, top: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(40),
                                topRight: Radius.circular(40)),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "Quantity"),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 35,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.grey.shade200),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: data.quantity != 1
                                              ? () {
                                                  data.decrementqty();
                                                }
                                              : () {},
                                          child: Icon(
                                            Icons.remove,
                                            color: data.quantity != 1
                                                ? Colors.black
                                                : Colors.grey,
                                          )),
                                      Text(data.quantity.toString()),
                                      InkWell(
                                          onTap: () {
                                            data.incrementqty();
                                          },
                                          child: Icon(Icons.add))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text('Total: ${data.total}',style: TextStyle(fontSize: 20),),
                                )
                              ],
                            ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 SizedBox(
                                   width:size.width/2,
                                   child: ElevatedButton(
                                       style: ButtonStyle(
                                           backgroundColor:
                                           MaterialStateProperty.all<Color>(
                                               Colors.orangeAccent),
                                           shape: MaterialStateProperty.all<
                                               RoundedRectangleBorder>(
                                             RoundedRectangleBorder(
                                                 borderRadius:
                                                 BorderRadius.circular(18.0),
                                                 side: BorderSide(color: Colors.white)),
                                           )),
                                       onPressed: () {},
                                       child: CustomText(
                                         text: "Add to Cart",
                                         color: Colors.white,
                                       )),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.only(right: 20),
                                   child: SizedBox(
                                     child: ElevatedButton(
                                         style: ButtonStyle(
                                             backgroundColor:
                                             MaterialStateProperty.all<Color>(
                                                 Colors.orangeAccent),
                                             shape: MaterialStateProperty.all<
                                                 RoundedRectangleBorder>(
                                               RoundedRectangleBorder(
                                                   borderRadius:
                                                   BorderRadius.circular(18.0),
                                                   side: BorderSide(color: Colors.white)),
                                             )),
                                         onPressed: () {},
                                         child: CustomText(
                                           text: "Buy now",
                                           color: Colors.white,
                                         )),
                                   ),
                                 )
                               ],
                             ),
                           )
                          ],
                        )),
                  )
                ],
              );
            } else {
              return Center(child: const CupertinoActivityIndicator());
            }
          }),
        ),
      ),
    );
  }
}
