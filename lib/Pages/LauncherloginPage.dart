import 'package:flutter/material.dart';
import 'package:gaminghub/Pages/HomePage.dart';

class LauncherLoginPage extends StatefulWidget {
  const LauncherLoginPage({super.key});

  @override
  State<LauncherLoginPage> createState() => _LauncherLoginPageState();
}

class _LauncherLoginPageState extends State<LauncherLoginPage> {
  bool rememberMe = true;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color(0xFF101B2D),
              Color.fromARGB(255, 14, 33, 71),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SizedBox(
              width: 1200,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: _buildLoginPanel()),

                    const SizedBox(width: 80),

                    Expanded(flex: 2, child: _buildQRPanel()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginPanel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.sports_esports, size: 128, color: Colors.white),
            SizedBox(width: 12),
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Column(
                children: [
                  Text(
                    "KS LAUNCHER",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 60),

        const Text(
          "Username",
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),

        const SizedBox(height: 10),

        TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF2D3647),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          "Password",
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),

        const SizedBox(height: 10),

        TextField(
          obscureText: obscurePassword,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF2D3647),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.white70,
              ),
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
            ),
          ),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Checkbox(
              value: rememberMe,
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  rememberMe = value!;
                });
              },
            ),
            const Text(
              "Remember Me",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: 450,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4E89FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: const Text(
              "LOGIN",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
        ),

        const SizedBox(height: 40),

        const Text(
          "* Login only verifies identity and does not collect personal information.",
          style: TextStyle(color: Colors.white38, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildQRPanel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Scan to Login",
          style: TextStyle(color: Colors.blue, fontSize: 22),
        ),

        const SizedBox(height: 20),

        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(Icons.qr_code_2, size: 200, color: Colors.black),
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          "Login using the KS Launcher mobile app",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      ],
    );
  }
}
