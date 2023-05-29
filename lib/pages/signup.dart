import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h =  MediaQuery.of(context).size.height;
    var _text = '';
    bool error_occured = false;

    void validateName(String name){
      if(name.length < 3 )error_occured = true;
      else error_occured = false;
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 248, 220,1),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Signup'),
      ),
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: h*0.03,),
            Padding(
              padding: EdgeInsets.fromLTRB(w*0.06, h*0.01, w*0.06, h*0.01),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            // SizedBox(),
            Padding(
              padding: EdgeInsets.fromLTRB(w*0.06, h*0.01, w*0.06, h*0.01),
              child: TextField(
                controller: nameController,
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
                  labelText: "Username",
                  labelStyle: TextStyle(
                    fontSize: 18,
                      color: Colors.orange
                  ),
                ),
              ),
            ),
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
                  labelText: "Email",
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
                controller: numController,
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
                  labelText: "Number",
                  labelStyle: TextStyle(
                    fontSize: 18,
                      color: Colors.orange,
                  ),
                ),
                keyboardType: TextInputType.number,
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
                obscureText:true,
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
                    final username = nameController.text;
                    final password = passwordController.text;
                    final number = numController.text;
                    final email = emailController.text;
                    print(username + " " +  number);
                    createUser(username, password, number, email);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange, // Background color
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30,15,30,15),
                    child: Text("Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                      ),),
                  ),
              ),
            ),
            SizedBox(height: 70),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/login');
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign in",
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

  Future createUser(String username, String password, String number, String email) async{
    email = email.toString().trim();
    password = password.toString().trim();
    final fbcol = FirebaseFirestore.instance.collection("users").doc();
    final user = User(int.parse(number), username, password, email);

    final json = user.toJson();
    await fbcol.set(json);

    Navigator.pushNamed(context, '/login');
  }
}
