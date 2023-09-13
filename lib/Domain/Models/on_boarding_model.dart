class SliderItem {
  final String title;
  final String subtitle;
  final String image;

  SliderItem({required this.title, required this.subtitle, required this.image});
}

class SliderViewObject
{
  SliderItem sliderItem;
  int numOfPages;
  int currentIndex;

  SliderViewObject({required this.sliderItem, required this.numOfPages, required this.currentIndex});
}