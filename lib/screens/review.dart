import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reslate/screens/review/matchCard.dart';
import 'dart:math';

import 'package:reslate/screens/review/multipleChoice.dart';

class reviewPage extends StatefulWidget {
  final String? docID;

  reviewPage({required this.docID});

  @override
  State<reviewPage> createState() => _reviewPageState();
}

class _reviewPageState extends State<reviewPage> {
  var numberOfQuestion = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.blue[600]!,
            Colors.blue[300]!,
            Colors.blue[100]!,
          ]),
        ),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 100, 20, 40),
                child: Text(
                  "Select Mode",
                  style: TextStyle(
                    color: Colors.white!,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 10, 40),
                  child: Column(
                    children: [
                      Text(
                        'Multiple Choice',
                        style: TextStyle(
                          color: Colors.blue[400]!,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                numberOfQuestion = 10;
                                setState(() {});
                              },
                              child: Text(
                                '10',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: numberOfQuestion == 10
                                        ? Colors.blue
                                        : Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: numberOfQuestion == 10
                                    ? Colors.white
                                    : Colors.blue[400],
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(15),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                numberOfQuestion = 20;
                                setState(() {});
                              },
                              child: Text(
                                '20',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: numberOfQuestion == 20
                                        ? Colors.blue
                                        : Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: numberOfQuestion == 20
                                    ? Colors.white
                                    : Colors.blue[400],
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(15),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                numberOfQuestion = 40;
                                setState(() {});
                              },
                              child: Text(
                                '40',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: numberOfQuestion == 40
                                        ? Colors.blue
                                        : Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: numberOfQuestion == 40
                                    ? Colors.white
                                    : Colors.blue[400],
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(15),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                numberOfQuestion = 60;
                                setState(() {});
                              },
                              child: Text(
                                '60',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: numberOfQuestion == 60
                                        ? Colors.blue
                                        : Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: numberOfQuestion == 60
                                    ? Colors.white
                                    : Colors.blue[400],
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: 250,
                          child: ElevatedButton(
                            onPressed: () async {
                              SystemSound.play(SystemSoundType.click);

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );

                              await getSavedWords(numberOfQuestion, true);

                              Navigator.of(context, rootNavigator: true).pop();

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return multipleChoice(
                                  docID: widget.docID,
                                  savedWordsData: true,
                                );
                              }));
                            },
                            child: Text("Saved words"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[400],
                                fixedSize: const Size(300, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: SizedBox(
                          width: 250,
                          child: ElevatedButton(
                            onPressed: () async {
                              SystemSound.play(SystemSoundType.click);

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );

                              await getSavedWords(numberOfQuestion, false);

                              Navigator.of(context, rootNavigator: true).pop();

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return multipleChoice(
                                  docID: widget.docID,
                                  savedWordsData: false,
                                );
                              }));
                            },
                            child: Text("Wrong answer"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[400],
                                fixedSize: const Size(300, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 10, 40),
                  child: Column(
                    children: [
                      Text(
                        'Match Card',
                        style: TextStyle(
                          color: Colors.blue[400]!,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: 250,
                          child: ElevatedButton(
                            onPressed: () async {
                              SystemSound.play(SystemSoundType.click);

                              //match card random method
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return matchCard();
                              }));
                            },
                            child: Text("Saved words"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[400],
                                fixedSize: const Size(300, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: SizedBox(
                          width: 250,
                          child: ElevatedButton(
                            onPressed: () async {
                              SystemSound.play(SystemSoundType.click);

                              //match card random method
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return matchCard();
                              }));
                            },
                            child: Text("Wrong answer"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[400],
                                fixedSize: const Size(300, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
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
      ),
    );
  }

  Future<void> getSavedWords(int numberOfQuestion, bool savedWordsData) async {
    List<Map<String, dynamic>> savedWords = [];
    print(numberOfQuestion);

    DocumentReference<Map<String, dynamic>> userDocumentRef =
        FirebaseFirestore.instance.collection("Profile").doc(widget.docID);
    QuerySnapshot<Map<String, dynamic>> savedWordsQuerySnapshot =
        await userDocumentRef.collection("savedWords").get();

    savedWordsQuerySnapshot.docs
        .forEach((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      Map<String, dynamic> data = doc.data();
      savedWords.add(data);
    });

    if (savedWords.isNotEmpty) {
      // Sort the savedWords list based on the chosen field and order
      String sortByField = savedWordsData ? "answerCorrect" : "answerWrong";
      savedWords.sort((a, b) => a[sortByField].compareTo(b[sortByField]));

      if (!savedWordsData) {
        savedWords = savedWords.reversed.toList();
      }

      Random random = Random();

      if (numberOfQuestion <= savedWords.length) {
        for (int a = 0; a < numberOfQuestion && a < savedWords.length; a++) {
          Map<String, dynamic> randomWord = savedWords[a];
          String thaiKey = randomWord['thai'];
          String engKey = randomWord['question'];
          String thaiKey1, thaiKey2, thaiKey3;
          List<dynamic> reviewList = randomWord['options'];

          try {
            if (reviewList.length < 5) {
              // Update the "beQuestion" field to true for the selected word
              savedWords[a]['beQuestion'] = true;

              // Initialize a list to store the random indices
              List<int> randomIndices = [];

              while (randomIndices.length < 3) {
                int randomIndex;
                do {
                  randomIndex = random.nextInt(savedWords.length);
                } while (randomIndex == a ||
                    randomIndices.contains(randomIndex)); // Avoid duplicates
                randomIndices.add(randomIndex);
              }

              // Get the Thai keys for the randomly selected incorrect answers
              List randomThaiKeys = randomIndices
                  .map((index) => savedWords[index]['thai'])
                  .toList();

              // Ensure that the correct answer is not in the list of incorrect answers
              randomThaiKeys.remove(thaiKey);

              thaiKey1 = randomThaiKeys[0];
              thaiKey2 = randomThaiKeys[1];
              thaiKey3 = randomThaiKeys[2];
              await saveChoice(engKey, thaiKey, thaiKey1, thaiKey2, thaiKey3);
            }
          } catch (e) {
            print('random choice error ${e}');
            Fluttertoast.showToast(msg: '${e}', gravity: ToastGravity.TOP);
          }
          // print('${a} = ${engKey}');
        }
      } else {
        Fluttertoast.showToast(
            msg: "คุณมีคำศัพท์ไม่ถึง ${numberOfQuestion} คำ",
            gravity: ToastGravity.TOP);
        return;
      }

      // Update the Firestore documents to set "beQuestion" to false for the remaining words
      for (int i = numberOfQuestion; i < savedWords.length; i++) {
        savedWords[i]['beQuestion'] = false;
      }

      // Update Firestore documents with the modified "beQuestion" values
      for (Map<String, dynamic> wordData in savedWords) {
        await userDocumentRef
            .collection("savedWords")
            .doc(wordData['question'])
            .set({'beQuestion': wordData['beQuestion']},
                SetOptions(merge: true));
      }
    } else {
      print('No savedWords available.');
    }
  }

  Future<void> saveChoice(
    question,
    correctAnswer,
    answer1,
    answer2,
    answer3,
  ) async {
    CollectionReference<Map<String, dynamic>> userCollection =
        FirebaseFirestore.instance.collection("Profile");

    try {
      DocumentReference<Map<String, dynamic>> newDocumentRef = userCollection
          .doc(widget.docID)
          .collection("savedWords")
          .doc(question);

      // Create an array of answers with the correct answer included
      List<String> answerArray = [correctAnswer, answer1, answer2, answer3];

      // Shuffle the answerArray to randomize the order
      answerArray.shuffle();

      // Find the index of the correct answer within the shuffled array
      int correctAnswerIndex = answerArray.indexOf(correctAnswer);

      Map<String, dynamic> dataToStore = {
        "options": answerArray,
        "answer_index": correctAnswerIndex,
      };
      await newDocumentRef.set(dataToStore, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }
}
