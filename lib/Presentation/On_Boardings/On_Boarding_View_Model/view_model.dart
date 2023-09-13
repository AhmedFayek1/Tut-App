import 'dart:async';


import 'package:easy_localization/easy_localization.dart';

import '../../../Domain/Models/on_boarding_model.dart';
import '../../Base_View_Model/base_view_model.dart';
import '../../Resources/assets_manager.dart';
import '../../Resources/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs,OnBoardingViewModelOutputs
{
  final StreamController<SliderViewObject> streamController = StreamController<SliderViewObject>();
  late final List<SliderItem> pages;
  int currentIndex = 0;

  @override
  void changePage(int index) {
    currentIndex = index;
    _postToStream();
  }

  @override
  int goToNextPage() {
    int nextIndex = ++currentIndex;
    if(nextIndex >= pages.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goToPreviousPage() {
    int previousIndex = --currentIndex;
    if(previousIndex < 0) {
      previousIndex = pages.length - 1;
    }
    return previousIndex;
  }

  @override
  void dispose() {
    streamController.close();
  }

  @override
  void start() {
    pages = getSlides();
    _postToStream();
  }

  @override
  // TODO: implement sliderSink
  Sink<SliderViewObject> get sliderSink => streamController.sink;

  @override
  // TODO: implement sliderStream
  Stream<SliderViewObject> get sliderStream => streamController.stream.map((sliderViewObject) => sliderViewObject);

  void _postToStream()
  {
    sliderSink.add(SliderViewObject(sliderItem: pages[currentIndex], numOfPages: pages.length, currentIndex: currentIndex));
  }

  //Get the list of slides
  List<SliderItem> getSlides() =>
      [
        SliderItem(
            title: StringsManager.onBoardingTitle1.tr(),
            subtitle: StringsManager.onBoardingDescription1.tr(),
            image: ImagesManager.onBoarding1),
        SliderItem(
            title: StringsManager.onBoardingTitle2.tr(),
            subtitle: StringsManager.onBoardingDescription2.tr(),
            image: ImagesManager.onBoarding2),
        SliderItem(
            title: StringsManager.onBoardingTitle3.tr(),
            subtitle: StringsManager.onBoardingDescription3.tr(),
            image: ImagesManager.onBoarding3),
        SliderItem(
            title: StringsManager.onBoardingTitle4.tr(),
            subtitle: StringsManager.onBoardingDescription4.tr(),
            image: ImagesManager.onBoarding4)
      ];

}

abstract class OnBoardingViewModelInputs
{
  int goToNextPage(); // This method is called when the user clicks on the next button
  int goToPreviousPage(); // This method is called when the user clicks on the previous button
  void changePage(int index); // This method is called when the user clicks on the page indicator

  Sink<SliderViewObject> get sliderSink; // This is the sink of the stream
}

abstract class OnBoardingViewModelOutputs
{
    Stream<SliderViewObject> get sliderStream; // This is the stream of the slider
}