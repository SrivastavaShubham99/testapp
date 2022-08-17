import 'package:bloc_experiment/data/request/booking_request.dart';
import 'package:bloc_experiment/data/response/booking_response.dart';
import 'package:bloc_experiment/payment_screen.dart';
import 'package:bloc_experiment/repository.dart';
import 'package:bloc_experiment/widget/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hive/hive.dart';

class BookingScreen extends StatefulWidget {
  final String mobileNumber;
  final String token;
  const BookingScreen(
      {Key? key, required this.mobileNumber, required this.token})
      : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TextEditingController? date = TextEditingController();
  TextEditingController? name = TextEditingController();
  TextEditingController? email = TextEditingController();
  TextEditingController? mobile_number = TextEditingController();
  int amount = 5000;
  // late Box access_token;
  int tax = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 50, left: 21),
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.arrow_back_ios, size: 24))),
            SizedBox(
              height: 100,
            ),
            getCommonTextEditingController(date!, "date"),
            getCommonTextEditingController(date!, "Name"),
            getCommonTextEditingController(date!, "Email"),
            getCommonTextEditingController(date!, widget.mobileNumber),
            Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('AMOUNT'),
                      Text('\u{20B9}${amount}'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('TAX'),
                      Text('\u{20B9}${tax}'),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: const EdgeInsets.only(top: 80, left: 16, right: 16),
              child: ElevatedButton(
                  onPressed: () => onPerformBooking(),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    )),
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                  ),
                  child: const Text("Book")),
            )
          ],
        ),
      ),
    );
  }

  onPerformBooking() async {
    final repo = Repository();
    BookingRequest bookingRequest =
        BookingRequest(date: "2022-02-05", total: "50");
    final response = await repo.performBooking(bookingRequest, widget.token);
    if (response.isSuccess!) {
      BookingResponse bookingResponse =
          BookingResponse.fromJson(response.dataResponse);
      Fluttertoast.showToast(msg: bookingResponse.message!);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentScreen()),
      );
    } else {
      Fluttertoast.showToast(msg: "something went wrong!!");
    }
  }
}
