
import 'package:flutter/material.dart';

import '../tools/variables.dart';

class CustomToggleButtons extends StatefulWidget{
  CustomToggleButtons({Key? key,required this.names,this.height = 100,this.onChange,required this.value}) : super(key: key);
  final List<String> names;
  final List<String> value;
  double height;
  Function(List<String>)? onChange;

  @override
  State<CustomToggleButtons> createState() => _ToggleButtonsState();
}

class _ToggleButtonsState extends State<CustomToggleButtons>{
  List<TextButton> buttons = [];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: SizedBox(
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
                    backgroundColor: MaterialStateProperty.all(widget.value.where((sname) => sname == name).length!=0?MyColors.secondary:MyColors.primary)
                ),
                onPressed: (){
                  setState(() {
                    bool isAlreadySelected = widget.value.where((sname) => sname == name).length!=0?true:false;
                    if(isAlreadySelected){
                      widget.value.remove(name);
                    }
                    else{
                      widget.value.add(name);
                    }
                    if(widget.onChange!=null){
                      widget.onChange!(widget.value);
                    }
                    // print(selectedNames);
                  });
                },
                child: Text(name,style: TextStyle(color: Colors.white,fontWeight: widget.value.where((sname) => sname == name).length!=0?FontWeight.bold:FontWeight.w100),)
            );
          }).toList(),
        ),
      ),
    );
  }
  
}