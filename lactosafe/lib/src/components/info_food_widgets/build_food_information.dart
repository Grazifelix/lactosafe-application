import 'dart:io';

import 'package:LactoSafe/src/components/info_food_widgets/risk_measuring_bar.dart';
import 'package:LactoSafe/src/controller/Info_food_controllers/food_risk_text_color.dart';
import 'package:LactoSafe/src/model/food_model.dart';
import 'package:LactoSafe/src/shared/app_text_en.dart';
import 'package:flutter/material.dart';
import '../../shared/app_colors.dart';
import '../../shared/app_settings.dart';

Widget buildFoodInformation({required FoodModel food}) {
  return Container(
    padding: const EdgeInsets.only(left: 30.0, right: 30, top: 30),
    alignment: Alignment.topCenter,
    child: SingleChildScrollView(
      child: Column(
        children: food.getIsFood
            ? [
                SizedBox(
                  child: Text(
                    food.getFoodName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 36,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Stack(alignment: Alignment.center, children: <Widget>[
                  SizedBox(
                    width: AppSettings.screenWidth,
                    height: AppSettings.screenHeight / 3,
                    child: ClipPath(
                      clipper: const ShapeBorderClipper(shape: CircleBorder()),
                      clipBehavior: Clip.hardEdge,
                      child: food.getUserFoodImage != null
                          ? Image.file(food.getUserFoodImage as File,
                              width: AppSettings.screenWidth / 4,
                              height: AppSettings.screenHeight / 2,
                              fit: BoxFit.cover)
                          : Container(
                              width: AppSettings.screenWidth / 4,
                              height: AppSettings.screenHeight / 2,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.grey,
                                  shape: BoxShape.circle),
                              child: const Text(
                                "Error loading image",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                  ),
                ]),

                SizedBox(
                  height: AppSettings.screenHeight / 15,
                ),
                RiskMeasuringBar(
                  foodRisk: food.getLactoseRisk,
                  foodRiskName: food.getLactoseRiskString,
                ),
                SizedBox(
                  height: AppSettings.screenHeight / 16,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.orange, width: 2),
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.emoji_objects_outlined,
                          color: AppColors.orange,
                          weight: 200,
                          size: 40,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                              text: translationEn.riskToContainLactose,
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 18,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            TextSpan(
                              text: '${food.getLactoseRiskString}.',
                              style: TextStyle(
                                color: foodRiskTextColor(
                                    foodRisk: food.getLactoseRisk),
                                fontSize: 18,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            food.getIngredientes.isNotEmpty
                                ? TextSpan(
                                    text:
                                        "\nReplace with lactose-free ${food.getFoodName}. ",
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                    ))
                                : const TextSpan(),
                            food.getIngredientes.isNotEmpty
                                ? TextSpan(
                                    text:
                                        "", //receitas precisa ser clicavel e que leve para um link externo
                                    style: TextStyle(
                                        color: AppColors.orange,
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.orange,
                                        decorationThickness: 2))
                                : const TextSpan()
                          ])),
                        )
                      ]),
                ),
                SizedBox(
                  height: AppSettings.screenHeight / 30,
                ),
                food.getIngredientes.isNotEmpty
                    ? Text(
                        "Ingredients that contain lactose in this food:",
                        style: TextStyle(
                            color: AppColors.grey,
                            fontFamily: 'Roboto',
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      )
                    : Container(),
                SizedBox(
                  height: AppSettings.screenHeight / 48,
                ),
                //transformar essa parte em um ListBuilder

                ListView.builder(
                    shrinkWrap: true,
                    itemCount: food.getIngredientes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.orange, width: 2),
                              borderRadius: BorderRadius.circular(24)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.gpp_maybe_outlined,
                                color: AppColors.orange,
                                size: 40,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                  child: Text(
                                food.getIngredientes[
                                    index], //nome do alimento precisa ser dinamico
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                ),
                              ))
                            ],
                          ),
                        ),
                      );
                    }),

                SizedBox(
                  height: AppSettings.screenHeight / 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${food.getFoodName} Nutrition Facts",
                    style: TextStyle(
                        color: AppColors.grey,
                        fontFamily: 'Roboto',
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                ),

                SizedBox(
                  height: AppSettings.screenHeight / 48,
                ),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppColors.pure_white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.047),
                          blurRadius: 30,
                          offset: Offset(0, 15),
                          spreadRadius: 20,
                        )
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nutrient",
                            style: TextStyle(
                                color: AppColors.grey,
                                fontFamily: "Roboto",
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          Text("Amount",
                              style: TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "Roboto",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: AppColors.backgroundColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Calories",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontFamily: "Roboto",
                                fontSize: 18,
                              ),
                            ),
                            Text(food.getCalorias,
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "Roboto",
                                  fontSize: 18,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: AppColors.backgroundColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Carbohydrates",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontFamily: "Roboto",
                                fontSize: 18,
                              ),
                            ),
                            Text(food.getCarboidrato,
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "Roboto",
                                  fontSize: 18,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: AppColors.backgroundColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Proteins",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontFamily: "Roboto",
                                fontSize: 18,
                              ),
                            ),
                            Text(food.getProteina,
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "Roboto",
                                  fontSize: 18,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: AppColors.backgroundColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Fat",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontFamily: "Roboto",
                                fontSize: 18,
                              ),
                            ),
                            Text(food.getGordura,
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "Roboto",
                                  fontSize: 18,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ]
            : [
                SizedBox(
                  width: 262,
                  height: 100,
                  child: Text(
                    "This is not a food",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Stack(alignment: Alignment.center, children: <Widget>[
                  SizedBox(
                    width: AppSettings.screenWidth,
                    height: AppSettings.screenHeight / 3,
                    child: ClipPath(
                      clipper: const ShapeBorderClipper(shape: CircleBorder()),
                      clipBehavior: Clip.hardEdge,
                      child: food.getUserFoodImage != null
                          ? Image.file(food.getUserFoodImage as File,
                              width: AppSettings.screenWidth / 4,
                              height: AppSettings.screenHeight / 2,
                              fit: BoxFit.cover)
                          : Container(
                              width: AppSettings.screenWidth / 4,
                              height: AppSettings.screenHeight / 2,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.grey,
                                  shape: BoxShape.circle),
                              child: const Text(
                                "Error loading image",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                  ),
                ]),
              ],
      ),
    ),
  );
}
