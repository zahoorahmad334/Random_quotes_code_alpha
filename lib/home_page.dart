import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:random_quotes/api.dart';
import 'package:random_quotes/quote_model.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool inProgress = false;
  QuoteModel? quote;

  @override
  void initState() {
    _fetchQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Check the current theme (Light or Dark)
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Lottie animation for background
            Lottie.asset(
              isDarkMode
                  ? 'assets/animations/Animation - 1732521290622.json' // Dark mode animation
                  : 'assets/animations/Animation - 1732521290622.json', // Light mode animation (same for now)
              repeat: true,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title Text
                    Text(
                      'Quotes',
                      style: TextStyle(
                        color: isDarkMode ? Colors.red : Colors.blue, // Adjust text color for themes
                        fontFamily: 'monospace',
                        fontSize: 24,
                      ),
                    ),
                    const Spacer(),

                    // Quote Text
                    Text(
                      quote?.q ?? "...........",
                      style: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'monospace',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Author Text
                    Text(
                      quote?.a ?? "... ..",
                      style: TextStyle(
                        fontSize: 20,
                        color: isDarkMode ? Colors.white54 : Colors.black54,
                        fontFamily: 'serif',
                      ),
                    ),
                    const Spacer(),

                    // Generate Button
                    inProgress
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: _fetchQuote,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? Colors.white
                            : Colors.blue, // Adjust button background
                      ),
                      child: Text(
                        'Generate',
                        style: TextStyle(
                          color: isDarkMode ? Colors.black87 : Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Share Button
                    ElevatedButton(
                      onPressed: () {
                        if (quote != null) {
                          final quoteText = '"${quote!.q}" - ${quote!.a}';
                          Share.share(quoteText); // Share functionality
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "No quote available to share.",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              backgroundColor:
                              isDarkMode ? Colors.red : Colors.yellow,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode ? Colors.blueGrey : Colors.orange,
                      ),
                      child: Text(
                        'Share Quote',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _fetchQuote() async {
    setState(() {
      inProgress = true;
    });
    try {
      final fetchQuote = await Api.fetchRandomQuote();
      debugPrint(fetchQuote.toJson().toString());
      setState(() {
        quote = fetchQuote;
      });
    } catch (e) {
      debugPrint("Failed to generate quote");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to generate quote!")),
      );
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
}
