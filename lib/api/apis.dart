import 'dart:convert';
import 'package:http/http.dart' as http;

 products() async {
  try {
    var url = Uri.parse('https://mobi.maaxkart.com/call-back-products-by-loc');
    var response = await http.post(url, body: {"location_id": "429"});
    if (response.statusCode == 200) {
      List<dynamic>respo=jsonDecode(response.body);
      return respo;
    } else {
      print(response.statusCode.toString());
    }
  } catch (e) {
    print("Product Error"+e.toString() );
  }
}
getDetails(id) async {
  try {
    var url = Uri.parse('https://mobi.maaxkart.com/call-back-product-by-id');
    var response = await http.post(url, body: {"product_id": id,"cust_id":"17"});
    if (response.statusCode == 200) {
      Map<String, dynamic>respo=jsonDecode(response.body);
      return respo;
    } else {
      print(response.statusCode.toString());
    }
  } catch (e) {
    print("Product Error"+e.toString() );
  }
}

ProductSearch(String item) async {
  try {
    var url = Uri.parse('https://mobi.maaxkart.com/call-back-productsearch');
    var response = await http.post(url, body: {"location_id":"429","keyword": item});
    if (response.statusCode == 200) {
      List<dynamic>respo=jsonDecode(response.body);
      return respo;
    } else {
      print(response.statusCode.toString());
    }
  } catch (e) {
    print("Search error"+e.toString() );
  }
}



