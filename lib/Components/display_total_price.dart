import 'package:flutter/material.dart';

class DisplayTotalPrice extends StatefulWidget {
  const DisplayTotalPrice({super.key});

  @override
  State<DisplayTotalPrice> createState() => _DisplayTotalPriceState();
}

class _DisplayTotalPriceState extends State<DisplayTotalPrice> {
  bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black26,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Display Total Price",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    "Included all fees, before taxes",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              Switch(
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                  value: isSwitch,
                  onChanged: (value){
                    setState(() {
                      isSwitch = value ;
                    });
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
