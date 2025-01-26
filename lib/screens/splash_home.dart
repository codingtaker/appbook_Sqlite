import 'package:appbook2/screens/accueil.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {


  const HomeScreen({super.key});

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purple, Colors.blue],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      'assets/img2.jpg',
                      height: 600,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 230,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 15,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Plongez dans des aventures sans fin😁",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,

                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Explorez les cultures, les histoires et les mondes au-delà de l'imagination grâce à notre bibliothèque.",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AccueilScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 255, 145, 0),
                                alignment: AlignmentDirectional.centerStart,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                              ),
                              child: const Text(
                                "Ma Bibliotheque",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          //   Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       children: [
          //         const SizedBox(height: 20),
          //         ElevatedButton(
          //           onPressed: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => const AccueilScreen(),
          //               ),
          //             );
          //           },
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: const Color.fromARGB(255, 255, 145, 0),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(12),
          //             ),
          //             padding: const EdgeInsets.symmetric(vertical: 15),
          //           ),
          //           child: const Text(
          //             "Ma Bibliotheque",
          //             style: TextStyle(
          //               fontSize: 18,
          //               color: Colors.white,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          ],
        ),
      ),
    );
  }
}
