import 'package:flutter/material.dart';

class PinKeyboard extends StatelessWidget {

  final double keyboardHeight;
  final Function(int) onButtonPressed;
  final Function onDeletePressed;

  PinKeyboard({
    this.keyboardHeight ,
    this.onButtonPressed,
    this.onDeletePressed,
  });

  Widget pinKeyboardInputButton({BuildContext context, label, VoidCallback onPressed}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 30.0,
                color: Theme.of(context).textTheme.subhead.color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget pinKeyboardActionButton({Widget label, VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: label,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {    
    return Container(
      height: keyboardHeight,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                pinKeyboardInputButton(
                    context: context,
                    label: "1",
                    onPressed: () {
                      onButtonPressed(1);
                    }),
                pinKeyboardInputButton(
                    context: context,                  
                    label: "2",
                    onPressed: () {
                      onButtonPressed(2);
                    }),
                pinKeyboardInputButton(
                    context: context,                  
                    label: "3",
                    onPressed: () {
                      onButtonPressed(3);
                    }),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                pinKeyboardInputButton(
                    context: context,                  
                    label: "4",
                    onPressed: () {
                      onButtonPressed(4);
                    }),
                pinKeyboardInputButton(
                    context: context,                  
                    label: "5",
                    onPressed: () {
                      onButtonPressed(5);
                    }),
                pinKeyboardInputButton(
                    context: context,                  
                    label: "6",
                    onPressed: () {
                      onButtonPressed(6);
                    }),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                pinKeyboardInputButton(
                    context: context,                  
                    label: "7",
                    onPressed: () {
                      onButtonPressed(7);
                    }),
                pinKeyboardInputButton(
                    context: context,                  
                    label: "8",
                    onPressed: () {
                      onButtonPressed(8);
                    }),
                pinKeyboardInputButton(
                    context: context,                  
                    label: "9",
                    onPressed: () {
                      onButtonPressed(9);
                    }),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 80.0,
                ),
                pinKeyboardInputButton(
                    context: context,                  
                    label: "0",
                    onPressed: () {
                      onButtonPressed(0);
                    }),
                pinKeyboardActionButton(
                    label: Icon(
                      Icons.backspace,
                      color: Theme.of(context).textTheme.subhead.color,
                    ),
                    onPressed: () {
                      onDeletePressed();
                    }),
              ],
            ),
          ),
        ],
      ));
  }
}