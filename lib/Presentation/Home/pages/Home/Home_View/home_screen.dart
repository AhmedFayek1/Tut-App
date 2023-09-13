import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:tut_app/App/dependency_injection.dart';
import 'package:tut_app/Domain/Models/home_data_model.dart';
import 'package:tut_app/Presentation/Common/State_Renderer/state_renderer_implementer.dart';
import 'package:tut_app/Presentation/Resources/router_manager.dart';
import 'package:tut_app/Presentation/Resources/values_manager.dart';
import '../../../../Resources/string_manager.dart';
import '../Home_Model_View/home_model_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  void bindViewModel() {
    _viewModel.start();
  }

  @override
  void initState() {
    bindViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowStates>(
      stream: _viewModel.outputStateStream,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(context,_getContent(context),() {_viewModel.start();}) ?? _getContent(context);
      },
    );
  }

  Widget _getContent(context) {
    return StreamBuilder<HomeObject>(
        stream: _viewModel.homeDataStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return  SingleChildScrollView(
              child: Column(
                children: [
                  _getBannersCarousal(snapshot.data!.homeDataModel!.banners),
                  _getText(text: StringsManager.services.tr()),
                  _getServices(snapshot.data!.homeDataModel!.services),
                  _getText(text: StringsManager.stores.tr()),
                  _getStores(snapshot.data!.homeDataModel!.stores),
                ],
              ),
            );
          } else {
            return Container();
          }
        }
    );
  }

  Widget _getBannersCarousal(List<BannerModel> banners) {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p10, bottom: AppPadding.p10),
      child: CarouselSlider(
        items: banners
            .map((e) => SizedBox(
            width: double.infinity,
            child: Card(
              elevation: AppSizes.s1,
              shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(AppSizes.s12)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                    Radius.circular(AppSizes.s12)),
                child: Image.network(
                  e.image,
                  fit: BoxFit.fill,
                ),
              ),
            )))
            .toList(),
        options: CarouselOptions(
          height: 200,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget _getText({String text = ""}) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p10, right: AppPadding.p10, top: AppPadding.p10,bottom: AppPadding.p10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 16),
        ),
      ),
    );
  }

  Widget _getServices(List<Service> services) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p10, right: AppPadding.p10),
      child: Center(
        child: SizedBox(
        height: AppSizes.s160,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: services.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: AppSizes.s150,
              child: services
                  .map((e) => Card(
                elevation: AppSizes.s1,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.s12)),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppSizes.s12)),
                      child: Image.network(
                        e.image,
                        fit: BoxFit.fill,
                        height: AppSizes.s120,
                      ),
                    ),
                    const SizedBox(
                      height: AppSizes.s5,
                    ),
                    Text(
                      e.title,
                      style:
                      Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
              ))
                  .toList()[index],
            );
          },
        ),
      ),
      ),
    );
  }

  Widget _getStores(List<Store> stores) {
    return Padding(padding: const EdgeInsets.all(10),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: stores.length,
          physics: const ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return stores
                .map((e) => SizedBox(
              height: AppSizes.s100,
              child: InkWell(
                onTap: () {
                  print("Store Clicked");
                  Navigator.pushNamed(context, AppRoutes.storeDetail);
                },
                child: Card(
                  elevation: AppSizes.s1,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppSizes.s12)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppSizes.s12)),
                    child: Image.network(
                      e.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ))
                .toList()[index];
          },
        )
    );
  }


  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

}
