
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test/api/apis.dart';
import 'package:machine_test/custom/custom_text.dart';
import 'package:machine_test/providers/provider_home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'details_screen.dart';

class ProductSearchPage extends StatefulWidget {
  bool? isroute = false;
  ProductSearchPage({Key? key,this.isroute}) : super(key: key);

  @override
  _ProductSearchPageState createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  List<dynamic>? itmesearch;
  bool isloading=true;
  TextEditingController _searchController=TextEditingController();
  Future<void>getsearchData()async{
    try{
      isloading =false;
      itmesearch= await ProductSearch(_searchController.text);
    }
    catch(e){
      print(e);
      print("search error");
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getsearchData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60), // Set this height
          child: Container(
            padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
            child: TextFormField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onChanged: (v){
                if(_searchController.text.length >= 2) {
                  getsearchData();
                  Provider.of<ProviderHome>(context, listen: false)
                      .getSearchDatas(_searchController.text);
                }},
              decoration: InputDecoration(
                  hintText: "search",
                  contentPadding:const EdgeInsets.only(top: 20,left: 10),
                  enabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(5),),borderSide: const BorderSide(color: Colors.orangeAccent),),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(const Radius.circular(5)),borderSide: BorderSide(color: Colors.orangeAccent)),
                  hintStyle: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.grey),
                  suffixIcon:IconButton(
                    onPressed:(){
                        _searchController.clear();
                        Navigator.pop(context);
                    },
                    icon:const Icon(Icons.clear,color: Colors.grey),
                  ),
                  border: InputBorder.none
              ),

            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0,left: 10),
          child: Consumer<ProviderHome>(
              builder: (context, data,child) {
                if (data.isitemsearching == false) {
                  var searchList=data.SearchmodelDatas;
                  return data.SearchmodelDatas !=  null?ListView.builder(
                      itemCount:data.SearchmodelDatas?.length,
                      itemBuilder: (context,index){
                        var image=Uri.parse('https://admin.maaxkart.com/' +data.SearchmodelDatas?[index]['image'] );
                        return Column(
                          children: [
                            ListTile(
                              onTap: (){
                                Navigator.push(context, PageTransition(child: DetailsScreen(id:data.SearchmodelDatas?[index]['id']),
                                    type: PageTransitionType.rightToLeft,
                                    duration: const Duration(seconds: 2)));   },
                              contentPadding: EdgeInsets.only(left: 10,right: 30,top: 10),
                             leading:ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: CachedNetworkImage(
                                    placeholder: (context, url) =>CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) =>
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(7),
                                          child: Icon(Icons.error),),
                                    imageUrl:'${image}',
                                    height:  110,
                                    width: 70,
                                    fit: BoxFit.cover),
                              ),
                              title: CustomText(text:'${searchList?[index]['pro_name']}',size: 15,),
                              subtitle:CustomText(text:'\u{20B9} ${searchList?[index]['price']}',size: 13,),
                              dense: true,
                            ),
                            Divider(thickness: 1,color: Colors.grey.shade400,endIndent: 10,),
                          ],
                        );
                      }): Text("No Data");
                }else{
                  return Container();
                }
              }),
        ),
      ),
    );
  }
}
