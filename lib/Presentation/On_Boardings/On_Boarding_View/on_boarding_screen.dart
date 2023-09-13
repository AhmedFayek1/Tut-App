import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/Presentation/Resources/values_manager.dart';

import '../../../Domain/Models/on_boarding_model.dart';

class OnBoardingView extends StatelessWidget {
  SliderItem sliderItem;
  OnBoardingView({required this.sliderItem,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: AppSizes.s60,),
          Text(sliderItem.title,style: Theme.of(context).textTheme.displayLarge,),
          const SizedBox(height: AppSizes.s8,),
          Text(sliderItem.subtitle,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
          const SizedBox(height: AppSizes.s60,),
          SvgPicture.asset(sliderItem.image),
        ],
      ),
    );
  }
}
