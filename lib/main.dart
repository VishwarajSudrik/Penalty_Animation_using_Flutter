import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PenaltyFormScreen(),
    );
  }
}

class PenaltyFormScreen extends StatefulWidget {
  @override
  _PenaltyFormScreenState createState() => _PenaltyFormScreenState();
}

class _PenaltyFormScreenState extends State<PenaltyFormScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool isSubmitted = false;
  bool isPhotoAdded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  void _submitPenalty() {
    setState(() {
      isSubmitted = true;
    });
  }

  void _addPhoto() {
    setState(() {
      isPhotoAdded = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("S2 - SwachhStations")),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text("Penalty", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
              SizedBox(height: 10),
              _buildTextField("Date", Icons.calendar_today, "2025-01-10"),
              SizedBox(height: 10),
              _buildDropdownField("Penalty Amount", ["1000", "2000", "5000"], "1000"),
              SizedBox(height: 10),
              _buildTextField("Remarks", Icons.note, "Enter remarks", isLarge: true),
              SizedBox(height: 10),
              _buildDropdownField("Status", ["Pending", "Approved", "Rejected"], "Pending"),
              SizedBox(height: 20),

              // Add Photo Button with Animation
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _addPhoto,
                    icon: Icon(Icons.add_a_photo, color: Colors.white),
                    label: Text("Add Photo"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                  ),
                  SizedBox(width: 10),
                  if (isPhotoAdded)
                    Icon(Icons.check_circle, color: Colors.green, size: 30),
                ],
              ),

              SizedBox(height: 20),

              // Submit Button with Animation
              Center(
                child: ElevatedButton(
                  onPressed: _submitPenalty,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSubmitted ? Colors.green : Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: isSubmitted
                      ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 8),
                      Text("Penalty Submitted", style: TextStyle(color: Colors.white)),
                    ],
                  )
                      : Text("Submit Penalty", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, String hint, {bool isLarge = false}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
      maxLines: isLarge ? 3 : 1,
    );
  }

  Widget _buildDropdownField(String label, List<String> options, String defaultValue) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: defaultValue,
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {},
        ),
      ),
    );
  }
}