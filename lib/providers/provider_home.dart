import 'package:flutter/material.dart';
import 'package:machine_test/api/apis.dart';
class ProviderHome with ChangeNotifier{

  List<dynamic>productDatas=[];
  Map<String, dynamic>? Details;
  bool isproductDatasLoading= true;
  bool isDetloading= true;
  int quantity =1;
  int total =0;
  int finalTotal =0;
  String? tot;
  incrementqty(){
    quantity += 1;
    total =finalTotal*quantity;
    print(finalTotal);
    notifyListeners();
  }
  decrementqty(){
    quantity -= 1;
    total =finalTotal* quantity;
    notifyListeners();
  }
  Future<void>getproducrt()async{
    try{
      isproductDatasLoading =false;
      productDatas =await products();
    }
    catch(e){
      print(e);
      isproductDatasLoading =true;
    }
    notifyListeners();
  }
Future<void>getDet(id)async{
    try{
      isDetloading =false;
      Details =await getDetails(id);
    //  quantity =int.parse(Details?['in_cart'] ?? "1");
      total =int.parse(Details?['selling_price'] ?? "0");
      final fintot=int.parse(Details?['selling_price'] ?? "0");
      finalTotal =fintot;
    }
    catch(e){
      print(e);
      isDetloading =true;
    }
    notifyListeners();
  }

  List<dynamic>? SearchmodelDatas;
  bool isitemsearching=true;
  Future<void>getSearchDatas(item)async{
    try{
      isitemsearching = false;
      SearchmodelDatas =await ProductSearch(item);
    }
    catch(e){
      print(e);
      isitemsearching =true;
    }
    notifyListeners();
  }


}