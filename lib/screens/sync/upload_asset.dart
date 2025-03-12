import 'dart:async';
import 'package:flutter/material.dart';

class UploadAssetPage extends StatefulWidget {
  @override
  _UploadAssetPageState createState() => _UploadAssetPageState();
}

class _UploadAssetPageState extends State<UploadAssetPage> {
  int currentStep = 0; // To track the current progress
  final TextEditingController _amountController = TextEditingController(); // Controller for amount input
  bool isUploading = false; // Track if the upload process has started
  String enteredAmount = ""; // Store entered amount

  @override
  void initState() {
    super.initState();
  }

  Future<void> _startUploadProcess() async {
    setState(() {
      isUploading = true;
      currentStep = 1;
    });

    // Simulate ZKP Generation
    await _generateZeroKnowledgeProof();
    // Simulate Onchain Commitment
    await _commitToChain();
    // Simulate Confirmation
    await _confirmOnchain();
  }

  Future<void> _generateZeroKnowledgeProof() async {
    setState(() {
      currentStep = 1;
    });
    await Future.delayed(Duration(seconds: 3)); // Simulating time for ZKP generation
  }

  Future<void> _commitToChain() async {
    setState(() {
      currentStep = 2;
    });
    await Future.delayed(Duration(seconds: 3)); // Simulating time for onchain commitment
  }

  Future<void> _confirmOnchain() async {
    setState(() {
      currentStep = 3;
    });
    await Future.delayed(Duration(seconds: 2)); // Simulating confirmation onchain

    // Show Success Dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Upload Complete"),
        content: Text("Your asset of $enteredAmount has been successfully uploaded and confirmed onchain!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int stepNumber, String label, bool isActive) {
    return Row(
      children: [
        Icon(
          isActive ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isActive ? Colors.green : Colors.grey,
          size: 30,
        ),
        SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: isActive ? Colors.green : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildAnimationPlaceholder(String text) {
    return Column(
      children: [
        SizedBox(height: 20),
        CircularProgressIndicator(),
        SizedBox(height: 20),
        Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Asset"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUploading) ...[
              Text(
                'Enter the amount you wish to upload to the blockchain:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Amount to upload',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_amountController.text.isNotEmpty) {
                    setState(() {
                      enteredAmount = _amountController.text;
                    });
                    _startUploadProcess();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter an amount to upload')),
                    );
                  }
                },
                child: Text('Upload'),
              ),
            ] else ...[
              _buildStepIndicator(1, "Generating Zero Knowledge Proof", currentStep >= 1),
              if (currentStep == 1) _buildAnimationPlaceholder("Generating ZKP..."),

              SizedBox(height: 20),
              _buildStepIndicator(2, "Committing Proof to Chain", currentStep >= 2),
              if (currentStep == 2) _buildAnimationPlaceholder("Committing to the chain..."),

              SizedBox(height: 20),
              _buildStepIndicator(3, "Onchain Confirmation", currentStep >= 3),
              if (currentStep == 3) _buildAnimationPlaceholder("Waiting for onchain confirmation..."),
            ],
          ],
        ),
      ),
    );
  }
}