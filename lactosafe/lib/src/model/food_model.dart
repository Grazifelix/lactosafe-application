import 'dart:convert';
import 'dart:io';

class FoodModel {
  String foodName;
  bool isFood;
  List ingredientes;
  String calorias;
  String carboidrato;
  String gordura;
  String proteina;
  String recipeUrl;
  int lactoseRisk;
  String lactoseRiskStr;
  File? userFoodImage;

  FoodModel(
      {required this.foodName,
      required this.isFood,
      required this.ingredientes,
      required this.calorias,
      required this.carboidrato,
      required this.gordura,
      required this.proteina,
      required this.recipeUrl,
      required this.lactoseRisk,
      required this.lactoseRiskStr});

  String get getFoodName => foodName;
  bool get getIsFood => isFood;
  List get getIngredientes => ingredientes;
  String get getCalorias => calorias;
  String get getCarboidrato => carboidrato;
  String get getGordura => gordura;
  String get getProteina => proteina;
  String get getRecipeUrl => recipeUrl;
  String get getLactoseRiskString => lactoseRiskStr;
  int get getLactoseRisk => lactoseRisk;
  File? get getUserFoodImage => userFoodImage;

  void setImage(File? newImage) {
    userFoodImage = newImage;
  }

  factory FoodModel.fromJson(Map<String, dynamic> data) {
    bool boolParsing(String boolType) {
      boolType = boolType.toLowerCase();
      if (boolType == "true") {
        return true;
      } else {
        return false;
      }
    }

    List verifyIngredientsList(dynamic ingredientsList){
      if(ingredientsList.runtimeType == [].runtimeType){
        print("É uma lista");
        return ingredientsList;
      } else if (ingredientsList.runtimeType == String) {
        print("É uma String");
        String ingredients = ingredientsList.replaceAll("\'", "\"");
        return jsonDecode(ingredients);
      } else {
        return [];
      }
      
    }

    final isFood = boolParsing(data["e_alimento"]);
    if (isFood == false) {
      return FoodModel(
        foodName: "",
        isFood: isFood,
        ingredientes: [],
        calorias: "",
        carboidrato: "",
        gordura: "",
        proteina: "",
        lactoseRisk: 0,
        lactoseRiskStr: "",
        recipeUrl: "",
      );
    } else {
      final name = data["alimento_nome"].toString();
      final ingredientes = verifyIngredientsList(data["ingredientes_com_lactose"]);
      final calorias = data["quantidade_calorias"].toString();
      final carboidrato = data["quantidade_carboidrato"].toString();
      final gordura = data["quantidade_gordura"].toString();
      final proteina = data["quantidade_proteina"].toString();
      final lactoseRisk = int.parse(data["risco_int"]);
      final lactoseRiskStr = data["risco_str"].toString();
      final recipeUrl = data["receitasemlactose_link"].toString();

      return FoodModel(
        foodName: name,
        isFood: isFood,
        ingredientes: ingredientes,
        calorias: calorias,
        carboidrato: carboidrato,
        gordura: gordura,
        proteina: proteina,
        lactoseRisk: lactoseRisk,
        lactoseRiskStr: lactoseRiskStr,
        recipeUrl: recipeUrl,
      );
    }
  }
}

late File? userFoodImage;
