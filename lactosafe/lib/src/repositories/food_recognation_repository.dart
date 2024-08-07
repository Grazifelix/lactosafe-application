import 'dart:convert';
import 'dart:io';
import 'package:LactoSafe/src/http/http_client.dart';
import 'package:LactoSafe/src/model/food_model.dart';

import '../http/exceptions.dart';

abstract class IFoodRecognationRepository {
  Future<FoodModel> getFoodsRecognation({required File image});
}

class FoodRecognizedRepository implements IFoodRecognationRepository {
  final HttpClientFoodRecognation client;
  static List<FoodModel> repository = [];

  FoodRecognizedRepository({required this.client});

  @override
  Future<FoodModel> getFoodsRecognation({required File image}) async {
    final response = await client.post(
        url:
            'https://lasctosafe-l4mdcvwrp-joao-vitors-projects-8d69260f.vercel.app/reconhecer-imagem',
        image: image,
        userId: "1");
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      print(responseString);
      
      final parsedJson = jsonDecode(responseString);

      FoodModel foodRecognized = FoodModel.fromJson(parsedJson);
      foodRecognized.setImage(image);
      return foodRecognized;
    }
   
    else if (response.statusCode == 404) {
      throw NotFoundExeption("A url informada não é válida");
    } else {
      throw Exception("Não foi possivel carregar os alimentos.");
    }
    throw Exception("Erro");
  }
}
