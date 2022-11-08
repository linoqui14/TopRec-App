
import 'package:flutter/material.dart';

import '../tools/variables.dart';

class CustomToggleButtons extends StatefulWidget{
  CustomToggleButtons({Key? key,required this.names,this.height = 100,this.onChange}) : super(key: key);
  final List<String> names;
  double height;
  Function(List<String>)? onChange;

  @override
  State<CustomToggleButtons> createState() => _ToggleButtonsState();
}

class _ToggleButtonsState extends State<CustomToggleButtons>{
  List<TextButton> buttons = [];
  List<String> selectedNames = [];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: widget.height,
      child: ListView(
        children: widget.names.map((name) {
          return TextButton(
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(80, 30)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:widget.names.indexOf(name)==0?BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20)):widget.names.indexOf(name)==widget.names.length-1?BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20)):BorderRadius.all(Radius.circular(0)),
                        // side: BorderSide(color: Colors.red)
                      )
                  ),
                  backgroundColor: MaterialStateProperty.all(selectedNames.where((sname) => sname == name).length!=0?MyColors.secondary:MyColors.primary)
              ),
              onPressed: (){
                setState(() {
                  bool isAlreadySelected = selectedNames.where((sname) => sname == name).length!=0?true:false;
                  if(isAlreadySelected){
                    selectedNames.remove(name);
                  }
                  else{
                    selectedNames.add(name);
                  }
                  if(widget.onChange!=null){
                    widget.onChange!(selectedNames);
                  }
                  // print(selectedNames);
                });
              },
              child: Text(name,style: TextStyle(color: Colors.white,fontWeight: selectedNames.where((sname) => sname == name).length!=0?FontWeight.bold:FontWeight.w100),)
          );
        }).toList(),
      ),
    );
  }
  
}