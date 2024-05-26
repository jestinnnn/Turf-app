import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:turf_nest/constants.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingState();
}

class _BookingState extends State<BookingScreen> {
  double animatedContainerHeight = 0;
  bool isAnimatedWidgetVisible = false;
  final RazorPayIntegration _razorPayIntegration = RazorPayIntegration();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double overlapHeight = screenHeight * 0.3;
    double middleHeight = screenHeight * 0.4;

    List<String> slots = List.generate(12, (index) => '${index + 1}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: Text(
          'Bookings',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              width: screenWidth,
              height: 0.3 * screenHeight,
              child: Container(
                height: middleHeight,
                color: AppColors.blue,
              ),
            ),
            Positioned(
              top: middleHeight - (overlapHeight),
              left: 0.07 * screenWidth,
              right: 0.07 * screenWidth,
              child: Container(
                height: 0.3 * screenHeight,
                width: 0.7 * screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Slot',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1.5,
                          ),
                          itemCount: slots.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  animatedContainerHeight = 70.0;
                                  isAnimatedWidgetVisible = true;
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(color: AppColors.green),
                                  ),
                                ),
                              ),
                              child: Text(slots[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              bottom: isAnimatedWidgetVisible ? 0 : -150,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Container(
                  height: 150,
                  color: AppColors.white2,

                  //add a table instead of this
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Slot Time: <data from database>',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Date: <data from database>',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Available: <data from database>',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ButtonStyles.mainButtonGreen(
                                  buttonText: "confirm",
                                ),
                                onPressed: () {
                                  _razorPayIntegration
                                      .initiateRazorPay(context);
                                  setState(() {
                                    isAnimatedWidgetVisible = false;
                                    animatedContainerHeight = 0.0;
                                  });
                                },
                                child: Text(
                                  'Confirm',
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ElevatedButton(
                                style: ButtonStyles.mainButton(
                                  buttonText: "confirm",
                                ),
                                onPressed: () {
                                  setState(() {
                                    isAnimatedWidgetVisible = false;
                                    animatedContainerHeight = 0.0;
                                  });
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////
class RazorPayIntegration {
  final Razorpay _razorpay = Razorpay();
  late BuildContext _context; // Store the context

  void initiateRazorPay(BuildContext context) {
    _context = context; // Assign the context to a class member
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    var options = {
      'key': 'rzp_test_aulsVSUg3RhaYX', // Replace with your actual Razorpay key
      'amount': 5 * 100, // Amount in paise (100 paise = ₹1)
      'name': 'Turf Nest',
      'description': 'Payment for services',
      'prefill': {'contact': 'John Doe', 'email': 'JohnDoe2024@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error initializing Razorpay: $e');
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(content: Text('Error initializing Razorpay')),
      );
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Payment successful: ${response.paymentId}');
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(content: Text('Payment successful')),
    );
    // Navigate to success screen or perform further actions
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment failed: ${response.code} - ${response.message}');
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(content: Text('Payment failed')),
    );
    // Navigate to error screen or perform further actions
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External wallet selected: ${response.walletName}');
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text('External wallet selected: ${response.walletName}'),
      ),
    );
  }
}