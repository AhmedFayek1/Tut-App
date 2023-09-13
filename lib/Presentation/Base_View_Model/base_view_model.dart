import 'dart:async';

import '../Common/State_Renderer/state_renderer_implementer.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs  {
    final StreamController _flowStateController = StreamController<FlowStates>.broadcast();

    @override
    Sink get inputStateSink => _flowStateController.sink;

    @override
    Stream<FlowStates> get outputStateStream => _flowStateController.stream.map((flowState) => flowState);


    @override
  void dispose() {
    _flowStateController.close();
  }

}

abstract class BaseViewModelInputs {
    void start(); // This method is called when the view is loaded
    void dispose(); // This method is called when the view is disposed

    Sink get inputStateSink;
}

abstract class BaseViewModelOutputs {
     //Stream<FlowStates> get outputStateStream;
}