import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:flutter/material.dart';
class StatefulWrapper extends StatefulWidget {
  final Function? onInit;
  final Function? dispose;
  final Widget? child;
  const StatefulWrapper({
        this.onInit,
        this.child,
        this.dispose
      });
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    widget.onInit!();
    super.initState();
  }

  @override
  void dispose() {
    widget.dispose!();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus( FocusNode());
          },
          child: CustomParentWidget(
            child: widget.child,
          )),
    );
  }
}
