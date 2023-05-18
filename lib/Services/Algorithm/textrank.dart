import 'package:flutter/material.dart';
import 'package:job_endear/Services/Algorithm/graph.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_endear/Models/sentence.dart';

class Algorithm {
  //Extract Sentences
  List<String> extractSentences(String description) {
    final sentences = <String>[];
    final text = description.trim();
    final sentencesInParagraph = text.split(RegExp(r'(?<=[.?!])\s+(?=[A-Z])'));
    for (final sentenceText in sentencesInParagraph) {
      sentences.add(sentenceText);
    }
    return sentences;
  }

  //Tokenize Sentences
  List<List<String>> tokenizeSentences(List<String> sentences) {
    final tokenized = <List<String>>[];
    for (final sentence in sentences) {
      final words = sentence.toLowerCase().split(' ');
      tokenized.add(words);
    }
    return tokenized;
  }
  //word embeding

  //Calculate Similarity
  double sentenceSimilarity(Sentence s1, Sentence s2) {
    final set1 = Set<String>.from(s1.words);
    final set2 = Set<String>.from(s2.words);
    final intersection = set1.intersection(set2).length;
    final union = set1.union(set2).length;
    return intersection / union;
  }

  //Apply TextRank

  // Define a function to summarize a document using TextRank and store the summary in Firebase
  Future<void> summarizeAndStore(
    String document,
    int numSentences,
    int maxSummaryLength,
    String projectId,
    String modelName,
  ) async {
    // Extract sentences from the document and tokenize them into words
    final sentences = extractSentences(document);

    // Create a graph of sentence similarities and calculate the importance score for each sentence using TextRank
    final List<Sentence> sentenceObjects = sentences
        .map((sentence) =>
            Sentence(sentences.indexOf(sentence), sentence.split(' ')))
        .toList();
    Graph<Sentence> graph = Graph<Sentence>();

    for (final s1 in sentenceObjects) {
      for (final s2 in sentenceObjects) {
        if (s1 != s2) {
          final weight = sentenceSimilarity(s1, s2);
          if (weight > 0) {
            graph.addEdge(s1, s2, weight);
          }
        }
      }
    }
    final ranking = graph.pageRank();

    // Sort the sentences in descending order by importance score
    final sorted = ranking.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Extract the top N sentences as the summary
    final topSentences = <Sentence>[];
    for (final entry in sorted.take(numSentences)) {
      topSentences.add(entry.key);
    }
    topSentences.sort((a, b) => a.index.compareTo(b.index));
    final summary = topSentences.map((sentence) => sentence.text).join(' ');

    // Store the summary in Firebase
    final firebaseApp = await Firebase.initializeApp();
    final firestore = FirebaseFirestore.instanceFor(app: firebaseApp);
    final collection = firestore
        .collection('projects')
        .doc(projectId)
        .collection('models')
        .doc(modelName)
        .collection('summaries');
    await collection.add({
      'document': document,
      'summary': summary.substring(0, maxSummaryLength),
    });
  }

  void test() {
    String description1 = "I like software development";
    String description2 = "I love software development very very much";
    List<String> s1 = extractSentences(description1);
    List<String> s2 = extractSentences(description2);
    List<List<String>> tokens1 = tokenizeSentences(s1);
    List<List<String>> tokens2 = tokenizeSentences(s2);
    Sentence sen1 = Sentence(1, tokens1[0]);
    Sentence sen2 = Sentence(2, tokens2[0]);
    double similarity = sentenceSimilarity(sen1, sen2);
    var graph = Graph<String>();
    graph.addEdge(description1, description2, similarity);
    graph.addEdge(description2, description1, similarity);

    var pR = graph.pageRank();
    debugPrint(pR.toString());
  }
}

// Future<String> get _localPath async {
//   final directory = await getApplicationDocumentsDirectory();

//   return directory.path;
// }

// Future<File> get _localFile async {
//   final path = await _localPath;
//   return File('$path/D:/Flutter Projects/job_endear/Word emb/glove.6B.50d.txt');
// }

// Future<void> generateembeddings() async {
//   try {
//     Map<String, List<double>> wordEmbeddings = {};

//     final File f = new File("D:/Flutter Projects/job_endear/Word emb/glove.6B.50d.txt");
//     debugPrint(f.toString());
//     final List<String> lines = await f.readAsLines(encoding:utf8); // use await here
//     debugPrint(lines[0]);

//     for (String line in lines) {
//       final List<String> values = line.split(' ');
//       final String word = values[0];
//       final List<double> embeds = values.sublist(1).map(double.parse).toList();
//       wordEmbeddings[word] = embeds;
//     }

//     debugPrint(wordEmbeddings["website"].toString());
//   } catch (e) {
//     debugPrint(e.toString());
//   }
//
