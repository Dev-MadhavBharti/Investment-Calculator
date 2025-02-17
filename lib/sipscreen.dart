import 'dart:math'; // Import dart:math for the pow function
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sipcalculator/Lumpsumscreen.dart';
import 'package:sipcalculator/mutualfundscreen.dart';

import 'emiscreen.dart';

class SipCalculator extends StatefulWidget {
  const SipCalculator({super.key});

  @override
  State<SipCalculator> createState() => _SipCalculatorState();
}

class _SipCalculatorState extends State<SipCalculator> {
  // Controllers for user inputs
  final TextEditingController _monthlyInvestmentController = TextEditingController();
  final TextEditingController _expectedReturnController = TextEditingController();
  final TextEditingController _timePeriodController = TextEditingController();

  // Variables to store calculation results
  double _totalInvestmentAmount = 0;
  double _estimatedReturn = 0;
  double _totalValue = 0;

  // Function to Calculate SIP Returns
  void calculateSIP() {
    // Retrieve user input values
    double monthlyInvestment = double.tryParse(_monthlyInvestmentController.text) ?? 0.0;
    double annualReturnRate = double.tryParse(_expectedReturnController.text) ?? 0.0;
    int timePeriod = int.tryParse(_timePeriodController.text) ?? 0;

    // Convert annual return rate to monthly and time period to months
    double monthlyReturnRate = annualReturnRate / 12 / 100;
    int totalMonths = timePeriod * 12;

    // Calculate total investment amount
    _totalInvestmentAmount = monthlyInvestment * totalMonths;

    // Calculate estimated returns using the SIP formula
    // FV = P * [(1 + r)^n - 1] / r * (1 + r)
    _estimatedReturn = monthlyInvestment *
        (pow(1 + monthlyReturnRate, totalMonths) - 1) /
        monthlyReturnRate *
        (1 + monthlyReturnRate);

    // Calculate total value (investment + returns)
    _totalValue = _estimatedReturn;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Text(
          "SIP Calculator",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        centerTitle: true,),
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

      body: Container(
        margin: EdgeInsets.only(top: 5),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Input fields
                SizedBox(height: 10),
                TextField(
                  controller: _monthlyInvestmentController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Monthly Investment (INR)",
                    prefixIcon: Icon(
                      Icons.currency_rupee_outlined,
                      color: Colors.greenAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _expectedReturnController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Expected Return Rate (p.a)",
                    suffixIcon: Icon(
                      Icons.percent_sharp,
                      color: Colors.greenAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _timePeriodController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Time Period (Years)",
                    suffixIcon: Icon(
                      Icons.timelapse_outlined,
                      color: Colors.greenAccent,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                // Button to calculate the results
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: calculateSIP,
                  child: Text(
                    "Calculate SIP",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                
                // Display container for results
                Container(
                  width: 400,
                  height: 250,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.greenAccent),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Results:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 15),
                      Text("Total Invested Amount:   ₹${_totalInvestmentAmount.toStringAsFixed(2)}",
                        style:TextStyle(
                          fontWeight:FontWeight.normal,
                          fontSize: 15
                        ) ,
                      ),
                      SizedBox(height: 10,),
                      Text("Estimated Return:   ₹${_estimatedReturn.toStringAsFixed(2)}",
                        style:TextStyle(
                            fontWeight:FontWeight.normal,
                            fontSize: 15
                        ) ,),
                      SizedBox(height: 10,),
                      Text("Total Value:    ₹${_totalValue.toStringAsFixed(2)}",
                        style:TextStyle(
                            fontWeight:FontWeight.normal,
                            fontSize: 15
                        ) ,),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text("SIP Calculator – Systematic Investment Plan Calculator", style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text("Prospective investors can think that SIPs and mutual "
                            "funds are the same. However, SIPs are merely a method of investing in mutual "
                            "funds, the other method being a lump sum. A SIP calculator is a tool "
                            "that helps you determine the returns you can avail when parking your funds in "
                            "such investment tools. Systematic Investment Plan or SIP is a process of investing "
                            "a fixed sum of money in mutual funds at regular intervals. SIPs usually allow you"
                            " to invest weekly, quarterly, or monthly.", style:
                          TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 30,),
                        
                        Text("What is a SIP Calculator?", style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text ("A SIP calculator is a simple tool that allows"
                             "individuals idea of the returns on their mutual"
    "fund investments made through SIP investments in mutual fund become one of the"
    "most popular  investment options for millennials lately."

                         "   These mutual fund sip calculators are designed to give potential "
                          "  investors an estimate on their mutual fund investments. However,"
                           "  the actual returns offered by a mutual fund scheme varies depending on various factors."
                          "  The SIP calculator does not provide clarification for the exit "
                          "  load and expense ratio (if any)."

                     "   This calculator will calculate the wealth gain and expected "
                      "  returns for your monthly SIP investment. Indeed, you get a rough estimate"
                       "  on the maturity amount for any of your monthly SIP, based on a "
                       "  projected annual return rate. " , style:
                        TextStyle(
                          fontWeight: FontWeight.w300,
                        ),),
SizedBox(height: 25,),
                        Text("Benefits of SIP calculators include –",style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text("1. Assists you to determine the amount you want to invest in."
                         " 2. Tells you the total amount you have invested."
                         " 3. Gives an estimated value of the returns",style:
                          TextStyle(
                            fontWeight: FontWeight.w300,
                          ),),

                        SizedBox(height: 40,)

                      ],
                    ),
                  ),
                )
              ],
            ),
            
          ),
        ),
      ),
    );
  }
}
