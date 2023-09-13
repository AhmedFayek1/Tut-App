import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/App/constants.dart';
import 'package:tut_app/Presentation/Common/State_Renderer/state_renderer.dart';

import '../../Resources/string_manager.dart';

abstract class FlowStates {
  States getStateRenderer();

  String getMessage();
}

class LoadingStateRenderer implements FlowStates {
  States stateRenderer;
  String message;

  LoadingStateRenderer(
      {required this.stateRenderer, this.message = StringsManager.loading});

  @override
  States getStateRenderer() => stateRenderer;

  @override
  String getMessage() => message;
}

class ErrorStateRenderer implements FlowStates {
  States stateRenderer;
  String message;

  ErrorStateRenderer({required this.stateRenderer, required this.message});

  @override
  States getStateRenderer() => stateRenderer;

  @override
  String getMessage() => message;
}

class EmptyStateRenderer implements FlowStates {
  String message;

  EmptyStateRenderer({required this.message});

  @override
  States getStateRenderer() => States.emptyScreenState;

  @override
  String getMessage() => message;
}

class ContentStateRenderer implements FlowStates {
  @override
  States getStateRenderer() => States.contentState;

  @override
  String getMessage() => AppConstants.emptyString;
}


extension FlowStateExtension on FlowStates {
  Widget getScreenWidget(
      BuildContext context, Widget content, Function retryFunction) {
    switch (runtimeType) {
      case LoadingStateRenderer:
        {
          if (getStateRenderer() == States.popUpLoadingState) {
            showPopUp(context, getStateRenderer(), getMessage());
            return content;
          } else {
            return StateRenderer(
              state: getStateRenderer(),
              message: getMessage(),
              retryFunction: retryFunction,
            );
          }
        }
      case ErrorStateRenderer:
        dismissCurrentDialog(context);
        if (getStateRenderer() == States.popUpErrorState) {
          showPopUp(context, getStateRenderer(), getMessage());
          return content;
        } else {
          return StateRenderer(
            state: getStateRenderer(),
            message: getMessage(),
            retryFunction: retryFunction,
          );
        }

      case EmptyStateRenderer:
        return StateRenderer(
          state: getStateRenderer(),
          message: getMessage(),
          retryFunction: retryFunction,
        );

      case ContentStateRenderer:
        dismissCurrentDialog(context);
        return content;

      default:
        dismissCurrentDialog(context);
        return content;
    }
  }

  isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)!.isCurrent != true;

  dismissCurrentDialog(BuildContext context) {
    if (isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopUp(BuildContext context, States state, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StateRenderer(
              state: state,
              message: message,
              retryFunction: () {
                Navigator.pop(context);
              },
            );
          });
    });
  }
}
