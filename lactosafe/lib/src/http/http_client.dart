// import 'dart:io';
// import 'package:http/http.dart' as http;

// abstract class IHttpClient {
//   Future post({required String url, required File? image});
// }

// class HttpClientFoodRecognation implements IHttpClient {
 

//   @override
//   Future post({required String url, required File? image}) async {
//     var request = http.MultipartRequest('POST', Uri.parse(url))
//     ..files.add(await http.MultipartFile.fromPath('image', image!.path));
    

//     return await request.send();
    
//   }

// }

import 'dart:io';
import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future post({required String url, required File? image, required String userId});
}

class HttpClientFoodRecognation implements IHttpClient {
 

  @override
  Future post({required String url, required File? image, required String userId}) async {
    var request = http.MultipartRequest('POST', Uri.parse(url))
    ..fields['user_id'] = userId
    ..files.add(await http.MultipartFile.fromPath('image', image!.path));
    

    return await request.send();
    
  }

}