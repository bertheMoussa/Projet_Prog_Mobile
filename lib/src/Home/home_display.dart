import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_dev_mobile/src/Question/Question_Model.dart';

class HomeDisplay extends StatelessWidget {
  const HomeDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
          onPressed: () => context.go("/categories"),
        ),
        title: const Center(
          child: Text(
            'Movements',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(
        color: Color(0xFF123456), // Change the background color of the screen as desired
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/pacMan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6FCF97), // Change the background color as desired
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Adjust the border radius as needed
                ),
              ),
              child: const Text(
                'Start',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/collect'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF63A4FF), // Change the background color as desired
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Adjust the border radius as needed
                ),
              ),
              child: const Text(
                'Collect Fruits',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/bubble'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFB946), // Change the background color as desired
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Adjust the border radius as needed
                ),
              ),
              child: const Text(
                'Bubble Game',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
