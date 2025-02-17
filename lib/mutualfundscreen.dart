import 'dart:math'; // Import dart:math for the pow function
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sipcalculator/Lumpsumscreen.dart';
import 'package:sipcalculator/emiscreen.dart';
import 'package:sipcalculator/sipscreen.dart';

class MutualFundCalculator extends StatefulWidget {
  const MutualFundCalculator({super.key});

  @override
  State<MutualFundCalculator> createState() => _MutualFundCalculatorState();
}

class _MutualFundCalculatorState extends State<MutualFundCalculator> {

  // Controllers for user inputs
  final TextEditingController _MutualFundInvestmentController = TextEditingController();
  final TextEditingController _expectedReturnController = TextEditingController();
  final TextEditingController _timePeriodController = TextEditingController();


  // Variables to store calculation results
  double _totalInvestmentAmount = 0;
  double _estimatedReturn = 0;
  double _totalValue = 0;

  // Function to Calculate SIP Returns
  void calculateLumpsum() {
    // Retrieve user input values
    double lumpsumInvestment = double.tryParse(_MutualFundInvestmentController.text) ?? 0.0;
    double annualReturnRate = double.tryParse(_expectedReturnController.text) ?? 0.0;
    int timePeriod = int.tryParse(_timePeriodController.text) ?? 0;

    // Convert annual return rate to decimal
    double annualReturnDecimal = annualReturnRate / 100;

    // Calculate future value using the lumpsum formula
    _totalInvestmentAmount = lumpsumInvestment;
    _totalValue = lumpsumInvestment * pow(1 + annualReturnDecimal, timePeriod);
    _estimatedReturn = _totalValue - _totalInvestmentAmount;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Text(
          "Mutual Fund Calculator",
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
                  controller: _MutualFundInvestmentController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: " Investment Amount (INR)",
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
                  onPressed: calculateLumpsum,
                  child: Text(
                    "Calculate",
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
                      Text("Total Value: ₹${_totalValue.toStringAsFixed(2)}  ",
                        style:TextStyle(
                            fontWeight:FontWeight.normal,
                            fontSize: 15
                        ) ,),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),


              ],
            ),

          ),
        ),
      ),
    );
  }
}
