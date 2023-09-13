import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tut_app/Domain/Models/home_data_model.dart';
import 'package:tut_app/Presentation/Base_View_Model/base_view_model.dart';

import '../../../../../Domain/Usecases/home_usecase.dart';
import '../../../../Common/State_Renderer/state_renderer.dart';
import '../../../../Common/State_Renderer/state_renderer_implementer.dart';

class HomeViewModel extends BaseViewModel with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _homeDataStreamController = BehaviorSubject<HomeObject>();


  final HomeUsecase _homeUseCase;
  HomeViewModel(this._homeUseCase);



  @override
  void start() {
        getHomeData();
  }

  @override
  void dispose() {
    _homeDataStreamController.close();
    super.dispose();
  }



  @override
  void getHomeData() async {
    inputStateSink.add(LoadingStateRenderer(stateRenderer: States.fullScreenLoadingState));
    (
        await _homeUseCase.execute(null)
    ). fold((left)  {
      inputStateSink.add(ErrorStateRenderer(stateRenderer: States.fullScreenErrorState, message: left.message!));
        }, (right)  {
          inputStateSink.add(ContentStateRenderer());
               _homeDataStreamController.add(right);
        });
  }

  @override
  Sink get homeDataSink => _homeDataStreamController.sink;

  @override
  Stream<HomeObject> get homeDataStream => _homeDataStreamController.stream.map((homeData) => homeData);
}

abstract class HomeViewModelInput {
  Sink get homeDataSink;

  void getHomeData();
}

abstract class HomeViewModelOutput {
  Stream<HomeObject> get homeDataStream;
}