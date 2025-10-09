import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              'Wallet',
              style: GoogleFonts.albertSans(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Container(
              width: double.infinity,
              height: 250,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SEKO',
                    style: GoogleFonts.albertSans(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '₹ 5000',
                    style: GoogleFonts.albertSans(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '**** 2734',
                    style: GoogleFonts.albertSans(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  /* Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      'https://upload.wikimedia.org/wikipedia/commons/0/04/Visa.svg',
                      width: 50,
                    ),
                  ),*/
                ],
              ),
            ),
            const SizedBox(height: 100),
            Center(
              child: Text(
                'Other Payment Methods',
                style: GoogleFonts.albertSans(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 75),
            // ignore: prefer_const_constructors
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Column(
                  children: [
                    Icon(Icons.qr_code, size: 50),
                    SizedBox(height: 8),
                    Text('UPI'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.credit_card, size: 50),
                    SizedBox(height: 8),
                    Text('Card'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.account_balance, size: 50),
                    SizedBox(height: 8),
                    Text('NetBanking'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Center(
              child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/delivery');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      '  Delivery Details  ',
                      style: GoogleFonts.albertSans(
                        color: const Color(0xFFFCD956),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
