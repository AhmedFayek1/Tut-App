import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tut_app/Presentation/Resources/color_manager.dart';
import 'package:tut_app/Presentation/Resources/values_manager.dart';

import '../../Resources/assets_manager.dart';
import '../../Resources/string_manager.dart';
import '../../Resources/style_manager.dart';

enum States
{
  // Pop Up Dialog States
  popUpLoadingState,
  popUpErrorState,

  // Full Screen Dialog States
  fullScreenLoadingState,
  fullScreenErrorState,
  emptyScreenState,

  // Content State
  contentState
}

class StateRenderer extends StatelessWidget {
  final States state;
  final String message;
  final String title;
  final Function retryFunction;

  const StateRenderer({
    super.key,
    required this.state,
    this.message = StringsManager.loading,
    this.title = "",
    required this.retryFunction
  });


  @override
  Widget build(BuildContext context) {
    return getStateWidgets(context);
  }

  Widget getStateWidgets(BuildContext context)
  {
    switch(state)
    {
      case States.popUpLoadingState:
        return getPopUpDialog(context, [
          getAnimatedImage(JsonManager.loading),
        ]);
      case States.popUpErrorState:
        return getPopUpDialog(context, [
          getAnimatedImage(JsonManager.error),
          getMessage(message),
          getButton(StringsManager.retryAgain.tr(),context),
        ]);
      case States.fullScreenLoadingState:
        return getColumnItems([
          getAnimatedImage(JsonManager.loading),
          getMessage(message),
        ]);
      case States.fullScreenErrorState:
        return getColumnItems([
          getAnimatedImage(JsonManager.error),
          getMessage(message),
          getButton(StringsManager.retryAgain.tr(),context),
        ]);
      case States.emptyScreenState:
        return getColumnItems([
          getAnimatedImage(JsonManager.empty),
          getMessage(message),
        ]);
      case States.contentState:
        return Container();
    }
  }

  Widget getPopUpDialog(BuildContext context, List<Widget> children)
  {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.s24),
      ),
      backgroundColor: Colors.transparent,
      elevation: AppSizes.s1,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          boxShadow: const [
            BoxShadow(
              color: ColorManager.black,
            ),
          ],
          borderRadius: BorderRadius.circular(AppSizes.s24),
          color: ColorManager.white,
        ),
        child: getDialogueContent(context,children),
      )
    );
  }

  Widget getDialogueContent(BuildContext context,List<Widget> children)
  {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }


  Widget getColumnItems(List<Widget> children)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget getMessage(String message)
  {
    return Text(message,style: regularText(color: ColorManager.black,fontSize: AppSizes.s20),);
  }

  Widget getAnimatedImage(String image)
  {
    return SizedBox(
      height: AppSizes.s100,
      width: AppSizes.s100,
      child: Lottie.asset(image)
    );
  }

  Widget getButton(String title,BuildContext context)
  {
    return ElevatedButton(
      onPressed: () {
        if(state == States.fullScreenErrorState)
          {
            retryFunction();
          }
        else
          {
            Navigator.pop(context);
          }
      },
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: SizedBox(
          width: double.infinity,
            child: Text(title,style: regularText(color: ColorManager.white,fontSize: AppSizes.s20),)),
      ),
    );
  }


}

