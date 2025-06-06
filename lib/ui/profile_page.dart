import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,),),
                    Icon(Icons.notifications_outlined,),
                  ],
                ),
                SizedBox(height: 15,),

                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.black54,
                      // backgroundImage: NetworkImage(
                      //   "${FirebaseAuth.instance.currentUser!.photoURL} ",
                      // ),
                      backgroundImage: AssetImage("images/flutterlogo.jpg"),
                    ),
                    SizedBox(width: size.width*0.03,),
                    Text.rich(
                      TextSpan(
                        // text: "${FirebaseAuth.instance.currentUser!.displayName} \n",
                        text: "Hasan Burney\n",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Show Profile",
                            style: TextStyle(fontSize: 16, color: Colors.black54,),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                SizedBox(height: 10,),
                Divider(color: Colors.black12,),
                SizedBox(height: 10,),
                Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "CozyGo your place\n",
                            style: TextStyle(height: 2.5, fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold,),
                            children: [
                              TextSpan(
                                text: "It's simple to set up and\n start earning.",
                                style: TextStyle(height: 1.2, fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400,),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.house_sharp, size: 100, color: Colors.redAccent,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Divider(color: Colors.black12,),
                SizedBox(height: 10,),
                Text("Settings", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500,),),
                SizedBox(height: 20,),
                profileInfo(Icons.person_2_outlined, "Personal information"),
                profileInfo(Icons.security, "Login and security"),
                profileInfo(Icons.payment_outlined, "Payments and payouts"),
                profileInfo(Icons.settings_outlined, "Accessibility"),
                profileInfo(Icons.note_outlined, "Taxes"),
                profileInfo(Icons.person_2_outlined, "Personal information"),
                profileInfo(Icons.translate, "Translation"),
                profileInfo(Icons.notifications_outlined, "Notifications"),
                profileInfo(Icons.lock_outline, "Privacy and sharing"),
                profileInfo(Icons.card_travel, "Travel for work"),
                SizedBox(height: 15,),

                Text("Hosting", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25,),),
                SizedBox(height: 20,),
                profileInfo(Icons.add_home, "List your space"),
                profileInfo(Icons.home, "Learn about hosting"),
                SizedBox(height: 15,),

                Text("Support", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25,),),
                SizedBox(height: 20,),
                profileInfo(Icons.help, "Visit the help center"),
                profileInfo(Icons.health_and_safety, "Get help with safety issues"),
                profileInfo(Icons.feedback_outlined, "Give us feedback"),
                SizedBox(height: 15,),

                Text("Legal", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25,),),
                SizedBox(height: 20,),
                profileInfo(Icons.menu_book_outlined, "Terms of service"),
                profileInfo(Icons.privacy_tip_sharp, "Privacy policy"),
                SizedBox(height: 15,),

                Text("Logout", style: TextStyle(color: Colors.black, fontSize: 18, decoration: TextDecoration.underline, decorationColor: Colors.black,),),
                SizedBox(height: 20,),
                Divider(color: Colors.black12,),
                SizedBox(height: 20,),
                Text("Version 20.25 (08122002)", style: TextStyle(fontSize: 10),),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding profileInfo(icon, name){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 25, color: Colors.black,),
              SizedBox(width: 20,),
              Text(name, style: TextStyle(fontSize: 17),),
              Spacer(),
              Icon(Icons.arrow_forward_ios,size: 18,),
            ],
          ),
          SizedBox(height: 12,),
          Divider(color: Colors.black12,),
        ],
      ),
    );
  }
}
