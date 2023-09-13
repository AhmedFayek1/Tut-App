import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:tut_app/App/dependency_injection.dart';
import 'package:tut_app/Domain/Models/store_details_model.dart';
import 'package:tut_app/Presentation/Common/State_Renderer/state_renderer_implementer.dart';
import 'package:tut_app/Presentation/Resources/values_manager.dart';
import 'package:tut_app/Presentation/Store_Details/store_details_viewmoel.dart';

import '../Resources/color_manager.dart';
import '../Resources/string_manager.dart';

class StoreDetailsScreen extends StatefulWidget {
  const StoreDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {

  final StoreDetailsViewModel _storeDetailsViewModel = instance<StoreDetailsViewModel>();

  void bindViewModel() {
    _storeDetailsViewModel.start();
  }

  @override
  void initState() {
    bindViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowStates>(
      stream: _storeDetailsViewModel.outputStateStream,
        builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(context,_getContent(context),() {_storeDetailsViewModel.start();}) ?? _getContent(context);
        }
    );
  }


  Widget _getContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsManager.stores.tr()),
      ),
      backgroundColor: ColorManager.white,
      body: StreamBuilder<StoreDetailsModel>(
          stream: _storeDetailsViewModel.storeDetailsStream,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return getStoreDetails(snapshot.data);
            } else {
              return Container();
            }
          }
      ),
    );
  }

  Widget getStoreDetails(StoreDetailsModel? store) {
    return SingleChildScrollView(
      child: Column(
          children: [
            SizedBox(
              height: AppSizes.s250,
              width: double.infinity,
              child: Image.network(store!.image,fit: BoxFit.cover,),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: Column(
              children: [
                _getText(text: StringsManager.details.tr()),
                Text(store.details),
                _getText(text: StringsManager.services.tr()),
                Text(store.services),
                _getText(text: StringsManager.aboutStore.tr()),
                Text(store.about),
              ],
            ),)

          ],
        ),
    );
  }

  Widget _getText({String text = ""}) {
    return Padding(
      padding: EdgeInsets.only(top: AppPadding.p20,bottom: AppPadding.p10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 16),
        ),
      ),
    );
  }

}

