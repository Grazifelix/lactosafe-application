import 'package:LactoSafe/src/components/info_food_widgets/emoji_risk_measuring_item.dart';
import 'package:LactoSafe/src/components/info_food_widgets/point_risk_measuring_itens.dart';
import 'package:LactoSafe/src/components/info_food_widgets/text_risk_measuring_itens.dart';
import 'package:LactoSafe/src/controller/Info_food_controllers/food_risk_text_color.dart';
import 'package:LactoSafe/src/shared/app_colors.dart';
import 'package:LactoSafe/src/shared/app_settings.dart';
import 'package:flutter/material.dart';

class RiskMeasuringBar extends StatelessWidget {
  final double foodRisk;
  final String foodRiskName;
  const RiskMeasuringBar({super.key, required this.foodRisk, required this.foodRiskName});

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: <Widget>[
      Row(
        children: [
          Container(
            width: AppSettings.screenWidth / 6,
            height: AppSettings.screenHeight / 24,
            decoration: ShapeDecoration(
              color: AppColors.greenShadow,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0)),
              ),
            ),
          ),
          Container(
            width: AppSettings.screenWidth / 6,
            height: AppSettings.screenHeight / 24,
            color: AppColors.green,
          ),
          Container(
            width: AppSettings.screenWidth / 6,
            height: AppSettings.screenHeight / 24,
            color: AppColors.yellow,
          ),
          Container(
            width: AppSettings.screenWidth / 6,
            height: AppSettings.screenHeight / 24,
            color: AppColors.orange,
          ),
          Container(
            width: AppSettings.screenWidth / 6,
            height: AppSettings.screenHeight / 24,
            decoration: ShapeDecoration(
              color: AppColors.red,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
              ),
            ),
          )
        ],
      ),
      pointRiskMeasuringItem(risk: foodRisk),
      emojiRiskMeasuringItem(risk: foodRisk),
      textRiskMeasuringItens(riskPorcentage: foodRisk, risk: foodRiskName)
    ]);
  }
}
