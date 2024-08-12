
import 'package:LactoSafe/src/shared/app_colors.dart';
import 'package:flutter/material.dart';

Color foodRiskTextColor({required int foodRisk}){
  switch(foodRisk){
    case 0:
      return AppColors.greenShadow;

    case > 0 && < 25:
      return AppColors.green;

    case >= 25 && <= 50:
      return AppColors.yellow;

    case > 50 && <= 75:
      return AppColors.orange;

    case > 75 && <= 100:
      return AppColors.red;

    default:
     return AppColors.grey;
  }
}