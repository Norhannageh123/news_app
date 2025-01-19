import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

// ignore: must_be_immutable
class SwitchWidget extends StatefulWidget {
 SwitchWidget({super.key,required this.text1,required this.text2,required this.onClicked});
  String text1;
  String text2;
  Function onClicked;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
   // var languageProvider=Provider.of<LanguageProvider>(context);
    return ToggleSwitch(
  minWidth: 90.0,
  cornerRadius: 20.0,
  activeBgColors: [[Colors.green[800]!], [Colors.red[800]!]],
  activeFgColor: Colors.white,
  inactiveBgColor: Colors.grey,
  inactiveFgColor: Colors.white,
  initialLabelIndex: 1,
  totalSwitches: 2,
  labels: [widget.text1, widget.text2],
  radiusStyle: true,
  onToggle: (index) {
    widget.onClicked();
    setState(() {
      
    });
    //print('switched to: $index');
  },
    );
  }
}