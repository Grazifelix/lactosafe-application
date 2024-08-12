import 'package:LactoSafe/src/shared/app_settings.dart';
import 'package:flutter/material.dart';

import '../../controller/Info_food_controllers/food_risk_text_color.dart';
import '../../controller/Info_food_controllers/risk_measuring_items_position_controller.dart';

Widget textRiskMeasuringItens({required int riskPorcentage, required String risk}){
  if (riskPorcentage <= 70) {
    return Positioned(
        top: 35,
        left: AppSettings.screenWidth / itemsRiskMeasuringPosition(foodRisk: riskPorcentage) - 12,
        child: Text(risk, style: TextStyle(color: foodRiskTextColor(foodRisk: riskPorcentage), fontFamily: 'Roboto', fontSize: 16, fontWeight: FontWeight.w900),));
  } else {
    return Positioned(
        top: 35,
        right: AppSettings.screenWidth / itemsRiskMeasuringPosition(foodRisk: riskPorcentage) - 12,
        child: Text(risk, style: TextStyle(color: foodRiskTextColor(foodRisk: riskPorcentage),fontFamily: 'Roboto', fontSize: 16, fontWeight: FontWeight.w900),));
  }
}