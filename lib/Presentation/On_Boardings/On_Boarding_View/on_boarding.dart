import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/App/app_preferences.dart';
import 'package:tut_app/App/dependency_injection.dart';
import 'package:tut_app/Presentation/On_Boardings/On_Boarding_View/on_boarding_screen.dart';
import 'package:tut_app/Presentation/On_Boardings/On_Boarding_View_Model/view_model.dart';
import 'package:tut_app/Presentation/Resources/assets_manager.dart';
import 'package:tut_app/Presentation/Resources/color_manager.dart';
import 'package:tut_app/Presentation/Resources/string_manager.dart';
import 'package:tut_app/Presentation/Resources/values_manager.dart';

import '../../../Domain/Models/on_boarding_model.dart';
import '../../Resources/router_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  AppPreferences appPreferences = instance<AppPreferences>();

  void _bindViewModel() {
    appPreferences.setIsOnBoardingViewed();
    _viewModel.start();
  }

  @override
  initState() {
    _bindViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.sliderStream,
        builder: (context, snapshot) {
          return getContent(snapshot.data);
        });
  }

  Widget getContent(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSizes.s0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: PageView.builder(
          controller: pageController,
          itemCount: sliderViewObject.numOfPages,
          onPageChanged: (int index) {
              _viewModel.changePage(index);
          },
          itemBuilder: (BuildContext context, int index) {
            return OnBoardingView(
              sliderItem: _viewModel.pages[index],
            );
          },
        ),
        bottomSheet: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
                child: Text(
                  StringsManager.skip.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: ColorManager.primary),
                ),
              ),
            ),
            getIndicatorRow(sliderViewObject)
          ],
        ),
      );
    }
  }

  Widget getIndicatorRow(SliderViewObject sliderViewObject) {
    return Container(
      height: 52,
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.s8),
            child: GestureDetector(
                onTap: () {
                  pageController.animateToPage(_viewModel.goToPreviousPage(),
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.linear);
                },
                child: SvgPicture.asset(
                  ImagesManager.leftArrow,
                  height: AppSizes.s20,
                  width: AppSizes.s20,
                )),
          ),
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfPages; i++)
                getCircle(i, sliderViewObject.currentIndex)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.s8),
            child: GestureDetector(
                onTap: () {
                  pageController.animateToPage(_viewModel.goToNextPage(),
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.linear);
                },
                child: SvgPicture.asset(ImagesManager.rightArrow,
                    height: AppSizes.s20, width: AppSizes.s20)),
          ),
        ],
      ),
    );
  }

  Widget getCircle(int i, int currentIndex) {
    return i == currentIndex
        ? Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: SvgPicture.asset(
              ImagesManager.hollowCircle,
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: SvgPicture.asset(
              ImagesManager.solidCircle,
            ),
          );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

}
