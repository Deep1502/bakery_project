import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bakery_project/services/controller.dart';

class Login extends StatelessWidget {

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 248, 220,1),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Login",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget{
  State<MyStatefulWidget> createState() => StateWidget();
}

class StateWidget extends State<MyStatefulWidget>{



  Controller ctrl = new Controller();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context){
    // ctrl.logout();
    double w = MediaQuery.of(context).size.width;
    double h =  MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 248, 220,1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h*0.01,),
            Padding(
              padding: EdgeInsets.fromLTRB(w*0.06, h*0.01, w*0.06, h*0.01),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: w*0.1,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            // SizedBox(),
            Padding(
              padding: EdgeInsets.fromLTRB(w*0.06, h*0.01, w*0.06, h*0.01),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: "Username/Email",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(w*0.06, h*0.01, w*0.06, h*0.01),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                  ),
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
            ),
            SizedBox(
              height: h*0.04,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: (){
                    String email = emailController.text.toString().trim();
                    String password = passwordController.text.toString().trim();
                    print("Email:  " + email +  " Password : " + password);
                    bool flag = false;
                    try{
                      FirebaseFirestore.instance
                          .collection('users')
                          .get()
                          .then((QuerySnapshot querySnapshot) {
                        querySnapshot.docs.forEach((doc) {
                          if((doc["email"] == email || doc["username"] == email)&& doc["password"] == password){
                            if(!flag){
                              flag = true;
                              ctrl.setLogin(email);
                            }
                            print("Login Successful!!");
                            Navigator.pushNamed(context, '/home');
                          }
                        });

                      });
                    }
                    catch(Exception){
                      if(!flag){
                        AlertDialog(
                          title: Text('Invalid Credentials'),
                        );
                      }
                    }
                    AlertDialog(
                      title: Text('Invalid Credentials!!'),
                    );

                    // Navigator.pushNamed(context, "/signup");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange, // Background color
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30,15,30,15),
                    child: Text("Login",
                      style: TextStyle(
                        fontSize: 20,
                      ),),
                  ),
              ),
            ),
            SizedBox(height: h*0.1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/mainPage');
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "Don\'t have an account? ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}