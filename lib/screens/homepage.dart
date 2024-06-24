import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  bool toggleMode = false;
  int _currentIndex = 0;
  late PageController _pageController;
  Timer? _timer;
  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: 1,
      initialPage: 0,
    );
    startAutoScrolling();
  }

  void startAutoScrolling() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        if (_currentIndex < 15) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }

        _pageController.animateToPage(_currentIndex,
            duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              toggleMode = !toggleMode;
              setState(() {});
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: !toggleMode
                      ? const NetworkImage(
                          "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRYTMcrChd0xogo54QFX2Ke8yxM_Gw5BhJjmTJ2AnvDtbB7o9Ne")
                      : const NetworkImage(
                          "https://t4.ftcdn.net/jpg/00/43/47/83/360_F_43478384_ldgEhe1lK2CpACBsCyQ1PU5nSAWAaTzB.jpg"),
                ),
                color: Colors.amber,
                borderRadius: BorderRadius.circular(40),
              ),
              child: GestureDetector(
                onTap: () {
                  toggleMode = !toggleMode;
                  setState(() {});
                },
                child: AnimatedAlign(
                  alignment:
                      toggleMode ? Alignment.centerLeft : Alignment.centerRight,
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Transform.rotate(
                        angle: pi * 2.26,
                        child: Image.asset(
                          "assets/images/airplane.png",
                          color:
                              toggleMode ? Colors.grey.shade600 : Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: PageView.builder(
              pageSnapping: true,
              onPageChanged: (value) {
                _currentIndex = value;
              },
              controller: _pageController,
              itemCount: 15,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  color: Colors.accents[Random().nextInt(5)],
                  height: 300,
                  child: Image.network(
                    "https://generatorfun.com/code/uploads/Random-Nature-image-${_currentIndex + 1}.jpg",
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
