import 'dart:io';

import 'package:LactoSafe/src/components/info_food_widgets/build_food_information.dart';
import 'package:LactoSafe/src/http/http_client.dart';
import 'package:LactoSafe/src/model/food_model.dart';
import 'package:LactoSafe/src/repositories/food_recognation_repository.dart';
import 'package:LactoSafe/src/shared/app_colors.dart';
import 'package:LactoSafe/src/shared/app_settings.dart';
import 'package:flutter/material.dart';

class InfoFoodPage extends StatefulWidget {
  const InfoFoodPage({super.key});
  static const routeName = '/InfoAlimento';

  @override
  State<InfoFoodPage> createState() => _InfoFoodPageState();
}

class _InfoFoodPageState extends State<InfoFoodPage> {
  final FoodRecognizedRepository foodStore =
      FoodRecognizedRepository(client: HttpClientFoodRecognation());
  Future<FoodModel>? _infoFoodFuture;

  @override
  void initState() {
    super.initState();
    _infoFoodFuture = myFuture();
  }

  Future<FoodModel> myFuture() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    final foodImage = ModalRoute.of(context)!.settings.arguments as File;
    Future<FoodModel> foodsRecognized =
        foodStore.getFoodsRecognation(image: foodImage);

    return foodsRecognized;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/home");
            },
            icon: const Icon(Icons.arrow_back_rounded),
            color: AppColors.orange,
            iconSize: 40.0,
            alignment: Alignment.topLeft,
          ),
        ),
        body: FutureBuilder(
            future: _infoFoodFuture,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30, top: 30),
                  child: Column(
                    children: [
                      Container(
                          width: AppSettings.screenWidth / 2,
                          height: 36,
                          decoration: BoxDecoration(
                              color: AppColors.shadow,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)))),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        width: AppSettings.screenWidth,
                        height: AppSettings.screenHeight / 3,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.shadow, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        height: AppSettings.screenHeight / 15,
                      ),
                      Container(
                          width: AppSettings.screenWidth,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.shadow,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)))),
                     SizedBox(
                        height: AppSettings.screenHeight / 16,
                      ),
                      Container(
                          width: AppSettings.screenWidth,
                          height: 100,
                          decoration: BoxDecoration(
                              color: AppColors.shadow,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)))),
                    ],
                  ),
                );
              } else {
                return buildFoodInformation(food: snapshot.data);
              }
            }));
  }
}
