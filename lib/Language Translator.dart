import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class lang extends StatefulWidget {
  const lang({super.key});

  @override
  State<lang> createState() => _langState();
}

class _langState extends State<lang> {
  var lang = [
    "Arabic",
    "Chinese",
    "English",
    "French",
    "German",
    "Greek",
    "Hebrew",
    "Hindi",
    "Italian",
    "Japanese",
    "Korean",
    "Polish",
    "Portuguese",
    "Romanian",
    "Russian",
    "Spanish",
    "Swedish",
    "Thai",
    "Turkish",
    "Vietnamese",
    "Gujarati", // Added Gujarati
  ];

  var originlang = 'English'; // Default to 'English'
  var destinationlang = 'Gujarati'; // Default to 'Gujarati'
  var output = '';
  var detectedLang = 'Detected Language';
  TextEditingController langcontroller = TextEditingController();
  bool isFirstInput = true; // Flag to prevent automatic language detection after the first input

  Map<String, String> languageCodes = {
    "English": "en",
    "Arabic": "ar",
    "Chinese": "zh",
    "French": "fr",
    "German": "de",
    "Greek": "el",
    "Hebrew": "he",
    "Hindi": "hi",
    "Italian": "it",
    "Japanese": "ja",
    "Korean": "ko",
    "Polish": "pl",
    "Portuguese": "pt",
    "Romanian": "ro",
    "Russian": "ru",
    "Spanish": "es",
    "Swedish": "sv",
    "Thai": "th",
    "Turkish": "tr",
    "Vietnamese": "vi",
    "Gujarati": "gu", // Added Gujarati language code
  };

  void translate(String dest, String input) async {
    if (input.isEmpty) {
      setState(() {
        output = "Please enter text to translate.";
      });
      return;
    }

    if (destinationlang == 'To') {
      setState(() {
        output = "Please select a destination language.";
      });
      return;
    }

    GoogleTranslator translator = GoogleTranslator();

    try {
      // Detecting language based on text input
      var translation = await translator.translate(input, from: 'auto', to: dest);

      // Updating UI
      setState(() {
        output = translation.text.toString();
        detectedLang = translation.sourceLanguage.name;
        originlang = detectedLang; // Automatically update "From" with detected language
      });
    } catch (e) {
      setState(() {
        output = "Error: Unable to translate.";
      });
    }
  }

  // Get language code for the language
  String getLanguageCode(String language) {
    return languageCodes[language] ?? "--"; // Default to '--' if language not found
  }

  // Swap 'From' and 'To' languages explicitly
  void swapLanguages() {
    setState(() {
      String temp = originlang;
      originlang = destinationlang;
      destinationlang = temp;
    });

    // After swapping, don't automatically trigger translation
    langcontroller.clear(); // Clear text field after swap
    setState(() {
      output = ''; // Clear output after swap
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EEF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D5078),
        title: const Text(
          "Language Translator",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              // From Language Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: const Text(
                            "From",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text(originlang),
                              items: lang.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  originlang = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: const Icon(Icons.swap_horiz,
                          color: Colors.black, size: 30),
                    ),
                    onPressed: swapLanguages,
                    tooltip: "Swap Languages",
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: const Text(
                            "To",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text(destinationlang),
                              items: lang.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  destinationlang = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Detected Language: $detectedLang",
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Input Text Field
              const Text(
                "Enter Text to Translate",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: langcontroller,
                    maxLines: 5,
                    decoration: const InputDecoration.collapsed(
                      hintText: "Type your text here...",
                    ),
                    onChanged: (text) {
                      if (isFirstInput) {
                        setState(() {
                          detectedLang = "Detecting...";
                        });

                        // Automatically detect language after text change
                        if (text.isNotEmpty) {
                          GoogleTranslator().translate(text, from: 'auto', to: 'en').then((value) {
                            setState(() {
                              detectedLang = value.sourceLanguage.name;
                              originlang = detectedLang; // Set detected language in 'From'
                              isFirstInput = false; // Prevent future detections
                            });
                          });
                        }
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Translate Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    translate(
                      getLanguageCode(destinationlang),
                      langcontroller.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D5078),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Translate",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Output Text
              const Text(
                "Translated Text",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    output.isEmpty ? "Translation will appear here." : output,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
