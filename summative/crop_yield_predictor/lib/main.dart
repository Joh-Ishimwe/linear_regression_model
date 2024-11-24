import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const CropYieldApp());
}

class CropYieldApp extends StatelessWidget {
  const CropYieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: CropYieldForm(),
      ),
    );
  }
}

class CropYieldForm extends StatefulWidget {
  const CropYieldForm({super.key});

  @override
  _CropYieldFormState createState() => _CropYieldFormState();
}

class _CropYieldFormState extends State<CropYieldForm> {
  // Input controllers
  final _yearController = TextEditingController();
  final _rainController = TextEditingController();
  final _pesticitesController = TextEditingController();
  final _tempController = TextEditingController();

  // Dropdown values
  String? selectedItem;
  String? selectedCountry;

  // Prediction result
  String predictionResult = "";

  // Dropdown options
  final items = ['Potatoes', 'Sweet Potatoes'];
  final countries = ['United Kingdom', 'Japan'];

  Future<void> predictYield() async {
    // Prepare API data
    final requestData = {
      "Item_Potatoes": selectedItem == "Potatoes" ? 1 : 0,
      "Area_United_Kingdoms": selectedCountry == "United Kingdom" ? 1 : 0,
      "Item_Sweet_potatoes": selectedItem == "Sweet Potatoes" ? 1 : 0,
      "Area_Japan": selectedCountry == "Japan" ? 1 : 0,
      "Years": int.parse(_yearController.text),
      "average_rain_fall_mm_per_year": double.parse(_pesticitesController.text),
      "pesticides_tonnes": double.parse(_tempController.text), // Default value for now
      "avg_temp": double.parse(_tempController.text),
    };

    try {
      // Send POST request to the FastAPI backend
      final response = await http.post(
        Uri.parse("https://fastapi-rm5x.onrender.com/predict/"), 
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          predictionResult = responseData["predicted_yield"].toString();
        });
      } else {
        setState(() {
          predictionResult = "Error: ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        predictionResult = "Failed to fetch prediction: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Image
            Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://www.shutterstock.com/shutterstock/photos/2499404003/display_1500/stock-photo-a-lush-rice-paddy-field-with-neat-under-a-bright-sunny-sky-green-rows-stretching-into-the-2499404003.jpg', // Use an appropriate URL
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      // color: Colors.black54,
                      child: const Text(
                        "Crop Yield Predictor",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      
                         IconButton(
                          icon: const Icon(Icons.person, size: 30, color: Colors.white),
                          onPressed: () {
                            // Share functionality can be added here
                          },
                        ),
                      const SizedBox(width: 300),
                      IconButton(
                          icon: const Icon(Icons.share, size: 30, color: Colors.white),
                          onPressed: () {
                            // Share functionality can be added here
                          },
                        ),
                      
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Input Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedItem,
                    decoration: const InputDecoration(
                      labelText: "Select Crop",
                      border: OutlineInputBorder(),
                    ),
                    items: items
                        .map((item) =>
                            DropdownMenuItem(value: item, child: Text(item)))
                        .toList(),
                    onChanged: (value) => setState(() => selectedItem = value),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedCountry,
                    decoration: const InputDecoration(
                      labelText: "Select Country",
                      border: OutlineInputBorder(),
                    ),
                    items: countries
                        .map((country) => DropdownMenuItem(
                            value: country, child: Text(country)))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => selectedCountry = value),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _yearController,
                    decoration: const InputDecoration(
                      labelText: "Enter Year",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _rainController,
                    decoration: const InputDecoration(
                      labelText: "Enter Avg Rain Fall(mm/year)",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _pesticitesController,
                    decoration: const InputDecoration(
                      labelText: "Enter Pesticides Tonnes",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _tempController,
                    decoration: const InputDecoration(
                      labelText: "Enter Avg Temp (°C)",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: predictYield,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                      ),
                      child: const Text("Predict", 
                      style: TextStyle(color: Colors.white, fontSize: 18),),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 80,
                    width: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Prediction: $predictionResult",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
