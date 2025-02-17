import 'package:flutter/material.dart';
import 'package:sipcalculator/Lumpsumscreen.dart';
import 'package:sipcalculator/mutualfundscreen.dart';
import 'dart:math';

import 'package:sipcalculator/sipscreen.dart';

class EmiCalculator extends StatefulWidget {
  const EmiCalculator({super.key});

  @override
  State<EmiCalculator> createState() => _EmiCalculatorState();
}

class _EmiCalculatorState extends State<EmiCalculator> {
  // Controllers for user input
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _rateOfInterestController = TextEditingController();
  final TextEditingController _loanTenureController = TextEditingController();

  // Variables to store results
  double? _emi;
  double? _totalInterest;
  double? _totalAmount;

  // Function to calculate EMI
  void calculateEmi() {
    try {
      // Parse inputs
      double loanAmount = double.parse(_loanAmountController.text);
      double rateOfInterest = double.parse(_rateOfInterestController.text) / (12 * 100);
      double loanTenure = int.parse(_loanTenureController.text) * 12;

      // EMI formula
      double emi = (loanAmount * rateOfInterest * pow(1 + rateOfInterest, loanTenure)) /
          (pow(1 + rateOfInterest, loanTenure) - 1);
      double totalAmount = emi * loanTenure;
      double totalInterest = totalAmount - loanAmount;

      // Update state
      setState(() {
        _emi = emi;
        _totalInterest = totalInterest;
        _totalAmount = totalAmount;
      });
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid input. Please enter valid numbers."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    _loanAmountController.dispose();
    _rateOfInterestController.dispose();
    _loanTenureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "EMI Calculator",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(

                decoration: BoxDecoration(
                  color: Colors.white60,
                ),
                child:Center(
                  child: Container(
                    width: 230,
                    height: 200,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)
                      ),
                      border: Border.all(
                        color: Colors.blue,
                      ),
                    ) ,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text("Some Popular Calculators", style: TextStyle(
                          fontSize: 25,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),),
                      ),
                    ),
                  ),
                )

            ),
            ListTile(
              title: Text('SIP Calculator', style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
              ),
              onTap: () {
                // Handle settings navigation
                // Navigate to SecondPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SipCalculator()),
                );
              },
            ),
            ListTile(
              title: Text('EMI Calculator', style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
              ),
              onTap: () {
                // Handle about navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmiCalculator()),
                );
              },
            ),
            ListTile(
              title: Text('Lumpsum Calculator', style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
              ),
              onTap: () {
                // Handle help navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LumpsumCalculator()),
                );
              },
            ),

            ListTile(
              title: Text('Mutual Fund Calculator', style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
              ),
              onTap: () {
                // Handle help navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MutualFundCalculator()),
                );
              },
            ),

            ListTile(
              title: Text('GST Calculator', style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
              ),
              onTap: () {
                // Handle help navigation
              },
            ),
          ],
        ),
      ),




      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input fields
              TextField(
                controller: _loanAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Loan Amount (INR)",
                  prefixIcon: const Icon(Icons.currency_rupee, color: Colors.green),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _rateOfInterestController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Rate of Interest (p.a.)",
                  suffixIcon: const Icon(Icons.percent, color: Colors.green),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _loanTenureController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Loan Tenure (Years)",
                  suffixIcon: const Icon(Icons.timelapse, color: Colors.green),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 30),
              // Calculate button
              ElevatedButton(
                onPressed: calculateEmi,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Calculate EMI",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              // Results display
              if (_emi != null)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Monthly EMI: ₹${_emi!.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Principal Amount: ₹${_loanAmountController.text}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Total Interest: ₹${_totalInterest!.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Total Amount Payable: ₹${_totalAmount!.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                ),
    Container(
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('''
      The credit market in India is steadily on the rise. It is currently the 4th largest credit industry in the world, recording a CAGR of over 11% year on year. A vast majority of these advances are short-term credits such as personal loans and credit cards. Combined, these two financial products account for 78% of all credit lending in India. Loan repayments include EMIs and borrowers should consider the EMI amount to accurately plan their current and future finances.
      ''' ,style:
    TextStyle(
    fontWeight: FontWeight.w400,
    ),
      )

            ],
          ),
        ),
      ),

   ]
    ),
        ),
    ),
    );
  }
}
