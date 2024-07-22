import 'package:LactoSafe/src/components/info_food_widgets/risk_measuring_bar.dart';
import 'package:LactoSafe/src/controller/Info_food_controllers/food_risk_text_color.dart';
import 'package:flutter/material.dart';
import '../../model/info_food_model.dart';
import '../../shared/app_colors.dart';
import '../../shared/app_settings.dart';

Widget buildFoodInformation({required FoodModel food}) {
  return Container(
    padding: const EdgeInsets.only(left: 30.0, right: 30, top: 30),
    alignment: Alignment.topCenter,
    child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: 262,
            height: 100,
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
                child: food.getImageUrl != null
                    ? Image.network(food.getImageUrl as String,
                        width: AppSettings.screenWidth / 4,
                        height: AppSettings.screenHeight / 2,
                        fit: BoxFit.cover)
                    : Container(
                        width: AppSettings.screenWidth / 4,
                        height: AppSettings.screenHeight / 2,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.grey, shape: BoxShape.circle),
                        child: const Text(
                          "Erro ao carregar imagem",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
            ),
            Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton(
                        heroTag: 'Favorite',
                        backgroundColor: AppColors.pure_white,
                        onPressed: () {},
                        child: Icon(
                          Icons.favorite_border_rounded,
                          color: AppColors.orange,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
              
                  ],
                )
              ],
            )
          ]),
          SizedBox(
            height: AppSettings.screenHeight / 15,
          ),
          RiskMeasuringBar(foodRisk: food.getLactoseRisk as double, foodRiskName: food.getLactoseRiskStr as String,),
          SizedBox(
            height: AppSettings.screenHeight / 16,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.orange, width: 2),
                borderRadius: BorderRadius.circular(24)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                    text: 'Risco de conter lactose: ',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  TextSpan(
                    text: '${food.getLactoseRiskStr}.',
                    style: TextStyle(
                      color: foodRiskTextColor(
                          risk: food.getLactoseRiskStr as String),
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                      text: "\nSubstitua por ${food.getFoodName} sem lactose: ",
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 18,
                        fontFamily: 'Roboto',
                      )),
                  TextSpan(
                      text:
                          "confira receitas.", //receitas precisa ser clicavel e que leve para um link externo
                      style: TextStyle(
                          color: AppColors.orange,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.orange,
                          decorationThickness: 2))
                ])),
              )
            ]),
          ),
          SizedBox(
            height: AppSettings.screenHeight / 30,
          ),
          Text(
            "Ingredientes que contém lactose neste alimento:",
            style: TextStyle(
                color: AppColors.grey,
                fontFamily: 'Roboto',
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: AppSettings.screenHeight / 48,
          ),
          //transformar essa parte em um ListBuilder
          Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.orange, width: 2),
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
                    "Nome do Alimento", //nome do alimento precisa ser dinamico
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                  ))
                ],
              )),
          SizedBox(
            height: AppSettings.screenHeight / 30,
          ),
          Text(
            "Tabela Nutricional do ${food.getFoodName} (por unidade de 30g):", //mudar para o nome do alimento ficar dinamico
            style: TextStyle(
                color: AppColors.grey,
                fontFamily: 'Roboto',
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),

          SizedBox(
            height: AppSettings.screenHeight / 48,
          ),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.pure_white,
                borderRadius: BorderRadius.circular(24), 
              
                boxShadow: const [BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.047),
                  blurRadius: 30,
                  offset: Offset(0, 15),
                  spreadRadius: 20,
                )]),
                
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nutriente",
                      style: TextStyle(
                          color: AppColors.grey,
                          fontFamily: "Roboto",
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text("Quantidade",
                        style: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Roboto",
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                    Text("%VD",
                        style: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Roboto",
                            fontSize: 18,
                            fontWeight: FontWeight.w600))
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
                        "Valor Energético",
                        style: TextStyle(
                          color: AppColors.grey,
                          fontFamily: "Roboto",
                          fontSize: 18,
                        ),
                      ),
                      Text("0",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Roboto",
                            fontSize: 18,
                          )),
                      Text("0",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Roboto",
                            fontSize: 18,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: AppColors.backgroundColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Carboidratos      ",
                        style: TextStyle(
                          color: AppColors.grey,
                          fontFamily: "Roboto",
                          fontSize: 18,
                        ),
                      ),
                      Text("0",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Roboto",
                            fontSize: 18,
                          )),
                      Text("0",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Roboto",
                            fontSize: 18,
                          ))
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
                        "Proteínas           ",
                        style: TextStyle(
                          color: AppColors.grey,
                          fontFamily: "Roboto",
                          fontSize: 18,
                        ),
                      ),
                      Text("0",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Roboto",
                            fontSize: 18,
                          )),
                      Text("0",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Roboto",
                            fontSize: 18,
                          ))
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
                        "Gorduras Totais",
                        style: TextStyle(
                          color: AppColors.grey,
                          fontFamily: "Roboto",
                          fontSize: 18,
                        ),
                      ),
                      Text("0",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Roboto",
                            fontSize: 18,
                          )),
                      Text("0",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Roboto",
                            fontSize: 18,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                
              ],
            ),
          ),
          SizedBox(height: 40,)
        ],
      ),
    ),
  );
}
