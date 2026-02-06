import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '/utils/enums/button_state.dart';
import 'appbar_actions.dart';

class ScreenWrapper extends StatelessWidget {
  final bool isFetching, isEmpty, isTyping, isTypingEmpty;
  final String emptyMessage, typingEmptyMessage;
  final Widget child;
  const ScreenWrapper(
      {this.typingEmptyMessage = '',
      required this.emptyMessage,
      this.isTypingEmpty = false,
      required this.isFetching,
      this.isTyping = false,
      required this.isEmpty,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    return isFetching
        ? SizedBox(
            height: 80.h,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WitIndicationFetching(
                      buttonState: KButtonState.processing,
                      size: 60,
                    ),
                  ],
                ),
              ],
            ),
          )
        : isTyping && isTypingEmpty
            ? WitScaffoldError(error: typingEmptyMessage)
            : isEmpty
                ? WitScaffoldError(error: emptyMessage)
                : child;
  }
}
