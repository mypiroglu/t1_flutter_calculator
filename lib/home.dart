import 'dart:core';
import 'dart:ffi';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String procces = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black54,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomRight,
              width: MediaQuery.of(context).size.width,
                color: Colors.black54,
                height: MediaQuery.of(context).size.width *.855,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(procces.toString(),style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,letterSpacing: 2.6,color: Colors.white),),
                )
            ),
            Row(
              children: [
                CustomButton(content: "C", color: false,onPressed: (){
                  setState(() {
                    procces = "";
                  });
                },),
                CustomButton(content: "±", color: false,onPressed: (){}),
                CustomButton(content: "%", color: false,onPressed: (){}),
                CustomButton(content: "÷", color: true,onPressed: (){}),
              ],
            ),
            Row(
              children: [
                CustomButton(content: "7", color: false,onPressed: (){
                  setState(() {
                    procces += "7";
                    print("procces son durumu: ${procces}");
                  });
                }),
                CustomButton(content: "8", color: false,onPressed: (){
                  setState(() {
                    procces += "8";
                    print("procces son durumu: ${procces}");
                  });
                }),
                CustomButton(content: "9", color: false,onPressed: (){
                  setState(() {
                    procces += "9";
                    print("procces son durumu: ${procces}");
                  });
                }),
                CustomButton(content: "X", color: true,onPressed: (){}),
              ],
            ),
            Row(
              children: [
                CustomButton(content: "4", color: false,onPressed: (){
                  setState(() {
                    procces += "4";
                    print("procces son durumu: ${procces}");
                  });
                }),
                CustomButton(content: "5", color: false,onPressed: (){
                  setState(() {
                    procces += "5";
                    print("procces son durumu: ${procces}");
                  });
                }),
                CustomButton(content: "6", color: false,onPressed: (){
                  setState(() {
                    procces += "6";
                    print("procces son durumu: ${procces}");
                  });
                }),
                CustomButton(content: "-", color: true,onPressed: (){}),
              ],
            ),
            Row(
              children: [
                CustomButton(content: "1", color: false,onPressed: (){
                  setState(() {
                    procces += "1";
                    print("procces son durumu: ${procces}");
                  });
                }),
                CustomButton(content: "2", color: false,onPressed: (){
                  setState(() {
                    procces += "2";
                    print("procces son durumu: ${procces}");
                  });
                }),
                CustomButton(content: "3", color: false,onPressed: (){
                  setState(() {
                    procces += "3";
                    print("procces son durumu: ${procces}");
                  });
                }),
                CustomButton(content: "+", color: true,onPressed: (){
                  setState(() {
                    procces += "+";
                  });
                }),
              ],
            ),
            Row(
              children: [
                CustomButton(content: "0", color: false,onPressed: (){
                  setState(() {
                    procces += "0";
                    print("procces son durumu: ${procces}");
                  });
                }),
                CustomButton(content: ",", color: false,onPressed: (){}),
                CustomButton(content: "=", color: true,onPressed: (){
                  setState(() {
                    List<String> parts = procces.split("+");
                    List<int> numbers = parts.map((part) => int.parse(part.trim())).toList();
                    int sum = 0;
                     for (int number in numbers){
                       sum += number;
                     }
                     procces = sum.toString();
                  });

                }),
              ],
            ),
          ],
        ),
        ),
      );
  }
}



class CustomButton extends StatefulWidget {
  final String content; // Parametre olarak alınan içerik
  final bool color; // Parametre olarak alınan renk durumu
  final VoidCallback onPressed;
  const CustomButton({Key? key, required this.content, required this.color, required this.onPressed})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: widget.content == "0" ? MediaQuery.of(context).size.width / 2 :MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.width / 4,
        color: widget.color ? Colors.orange : Colors.black26,
        child: Center(
          child: Text(
            widget.content,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

