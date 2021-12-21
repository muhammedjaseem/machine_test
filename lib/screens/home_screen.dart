import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test/custom/custom_search_button.dart';
import 'package:machine_test/custom/custom_text.dart';
import 'package:machine_test/providers/provider_home.dart';
import 'package:machine_test/screens/details_screen.dart';
import 'package:machine_test/screens/search_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProviderHome>(context, listen: false).getproducrt();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.orangeAccent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      )),
                  CustomSearchButton()
                ],
              ),
              color: Colors.orangeAccent,
            ),
          ),
          body: Consumer<ProviderHome>(
            builder: (context,data,child) {
              return data.isproductDatasLoading == false?Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: Colors.white),
                  padding: const EdgeInsets.only(top: 30),
                  child: ListView.builder(
                      itemCount: data.productDatas.length,
                      itemBuilder: (context, index) {
                        var image=Uri.parse('https://admin.maaxkart.com/' +data.productDatas[index]['image'] );
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, PageTransition(child: DetailsScreen(id:data.productDatas[index]['id']),
                                  type: PageTransitionType.rightToLeft,
                                  duration: const Duration(seconds: 2)));
                            },
                            child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade100,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                     Padding(
                                      padding: EdgeInsets.only(left: 8.0, right: 20.0),
                                      child: CircleAvatar(
                                        maxRadius: 40,
                                        minRadius: 40,
                                        backgroundColor: Colors.grey.shade100,
                                        backgroundImage: NetworkImage(
                                            '${image}'),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            constraints:const BoxConstraints(maxWidth: 210),
                                            child: CustomText(
                                              text: data.productDatas[index]['pro_name'],
                                              size: 18,
                                              textOverflow: TextOverflow.ellipsis,
                                              mxlines: 1,

                                            ),
                                          ),
                                          CustomText(
                                            text: data.productDatas[index]['category_name'],
                                            size: 14,
                                            color: Colors.grey,
                                          ),
                                          Row(
                                            children:  [
                                              Padding(
                                                  padding: EdgeInsets.only(right: 8.0),
                                                  child: Text(
                                                    '\u{20B9}  ${data.productDatas[index]['price']}' ,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color:  Colors.grey,
                                                        decoration:
                                                            TextDecoration.lineThrough),
                                                  )),
                                              Text(
                                                '\u{20B9}  ${data.productDatas[index]['selling_price']}',
                                                style: const TextStyle(
                                                    fontSize: 15,),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      })):Center(child: const CupertinoActivityIndicator());
            }
          )),
    );
  }
}
