import 'package:flutter/material.dart';
import 'package:kapiot/ui/rider/components/request_accepted_panel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RequestAcceptedView extends StatelessWidget {
  const RequestAcceptedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.55;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
            body: SlidingUpPanel(
          minHeight: panelHeightClosed,
          maxHeight: panelHeightOpened,
          parallaxEnabled: true,
          parallaxOffset: 0.5,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          body: Expanded(
            child: Container(
              child: Center(
                child: Text("Here lies Map"),
              ),
            ),
          ),
          panelBuilder: (controller) => PanelWidget(
            controller: controller,
          ),
        ));
      },
    );
  }
}
