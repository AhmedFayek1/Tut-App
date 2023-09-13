import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tut_app/Domain/Usecases/store_details_usecase.dart';

import '../../Domain/Models/store_details_model.dart';
import '../Base_View_Model/base_view_model.dart';
import '../Common/State_Renderer/state_renderer.dart';
import '../Common/State_Renderer/state_renderer_implementer.dart';

class StoreDetailsViewModel extends BaseViewModel with StoreDetailsInputs, StoreDetailsOutputs   {

  final StreamController _storeDetailsStreamController = BehaviorSubject<StoreDetailsModel>();

  final StoreDetailsUsecase _storeDetailsUsecase;
  StoreDetailsViewModel(this._storeDetailsUsecase);

  @override
  void start() {
    getStoreDetails();
  }



  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  @override
  Sink get storeDetailsSink => _storeDetailsStreamController.sink;

  @override
  Stream<StoreDetailsModel> get storeDetailsStream => _storeDetailsStreamController.stream.map((storeDetails) => storeDetails);

  @override
  void getStoreDetails() async {
    inputStateSink.add(LoadingStateRenderer(stateRenderer: States.fullScreenLoadingState));
    (
        await _storeDetailsUsecase.execute(null)
    ). fold((left)  {
    inputStateSink.add(ErrorStateRenderer(stateRenderer: States.fullScreenErrorState, message: left.message!));
    }, (right)  {
    inputStateSink.add(ContentStateRenderer());
    _storeDetailsStreamController.add(right);
    });
  }
}

abstract class StoreDetailsInputs
{
  Sink get storeDetailsSink;

  void getStoreDetails();
}

abstract class StoreDetailsOutputs
{
  Stream<StoreDetailsModel> get storeDetailsStream;
}