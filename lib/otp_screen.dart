import 'package:bloc_experiment/booking_screen.dart';
import 'package:bloc_experiment/data/request/otp_request.dart';
import 'package:bloc_experiment/data/response/otp_response.dart';
import 'package:bloc_experiment/repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hive/hive.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  const OtpScreen({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController? textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 40),
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.arrow_back_ios, size: 24))),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 120),
                child: const Text("OTP", style: TextStyle(fontSize: 30)),
              ),
              Container(
                margin: EdgeInsets.only(top: 120, right: 16),
                child: TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF2F2F2),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: Colors.orange),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                          width: 1,
                        )),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide:
                            BorderSide(width: 1, color: Colors.yellowAccent)),
                    hintText: "OTP",
                    hintStyle:
                        TextStyle(fontSize: 16, color: Color(0xFFB3B1B1)),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.only(top: 80, right: 16),
                child: ElevatedButton(
                    onPressed: () => onPerformOtpVerification(),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.purple),
                    ),
                    child: const Text("Login via OTP")),
              )
            ],
          ),
        ),
      ),
    );
  }

  onPerformOtpVerification() async {
    final repo = Repository();
    OtpRequest otpRequest = OtpRequest(
        otp: textEditingController!.text, mobile: widget.mobileNumber);
    final response = await repo.performOtpVerification(otpRequest);
    if (response.isSuccess!) {
      try {
        OtpResponse otpResponse = OtpResponse.fromJson(response.dataResponse);
        if(otpResponse.status!){
          Fluttertoast.showToast(msg: otpResponse.message!);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookingScreen(
                  mobileNumber: widget.mobileNumber,
                  token: otpResponse.token!,
                )),
          );
        }else{
          Fluttertoast.showToast(msg: "Wrong OTP entered!");
        }

      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      Fluttertoast.showToast(msg: "something went wrong!!");
    }
  }
}
