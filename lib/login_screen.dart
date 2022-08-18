

import 'package:bloc_experiment/data/request/login_request.dart';
import 'package:bloc_experiment/data/response/login_response.dart';
import 'package:bloc_experiment/otp_screen.dart';
import 'package:bloc_experiment/repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginScreen extends StatefulWidget {
  final DateTime dateTime;
  const LoginScreen({Key? key, required this.dateTime}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController? textEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 16),
        child: Column(
          children:  [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 120),
              child: const Text("Login",style: TextStyle(
                fontSize: 30
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: 120,right: 16),
              child: TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF2F2F2),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.red),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.orange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1,color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1,)
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1,color: Colors.black)
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
                  ),
                  hintText: "enter phone number",
                  hintStyle: TextStyle(fontSize: 16,color: Color(0xFFB3B1B1)),

                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: const EdgeInsets.only(top: 80,right: 16),
              child: ElevatedButton(
                  onPressed: ()=> onPostRequest(),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                          )
                      ),
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                  ),
                  child: const Text("Login")
              ),
            )
          ],
        ),
      ),
    );
  }

  onPostRequest() async{
    final repo=Repository();
    LoginRequest loginRequest=LoginRequest(
      mobile: textEditingController!.text
    );
    final response= await repo.performLogin(loginRequest);
    if(response.isSuccess!){
      LoginResponse loginResponse=LoginResponse.fromJson(response.dataResponse);
      Fluttertoast.showToast(msg: loginResponse.message!);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  OtpScreen(mobileNumber: textEditingController!.text)),
      );
    }else{
      Fluttertoast.showToast(msg: "something went wrong!!");
    }
  }
}
