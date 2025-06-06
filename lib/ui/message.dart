import 'package:demo/Components/my_icon_button.dart';
import 'package:flutter/material.dart';

import '../model/message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<String> messageScreenType = ["All","Travelling","Support"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(),
                  Spacer(),
                  MyIconButton(
                    icon: Icons.search,
                    radius: 23,
                    color: Colors.black12.withOpacity(0.03),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Text("Message",style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      messageScreenType.length,
                      (index) => GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                            decoration: BoxDecoration(
                              color: selectedIndex == index ? Colors.black : Colors.black12.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              messageScreenType[index],
                              style: TextStyle(
                                color: selectedIndex == index ? Colors.white : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(height: 10,),
              ...messages.map((message) => _buildMessageItem(message)),
            ],
          ),
        ),
      ),
    );
  }




  Widget _buildMessageItem(Message message){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 85,
                width: 75,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(message.image),
                  ),
                ),
              ),
              Positioned(
                bottom: -10,
                right: -18,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(message.vendorImage),
                  backgroundColor: Colors.white,
                  radius: 25,
                ),
              ),
            ],
          ),
          SizedBox(width: 25,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      message.name,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      message.date,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Text(
                  message.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.1,
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  message.duration,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.4,
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
