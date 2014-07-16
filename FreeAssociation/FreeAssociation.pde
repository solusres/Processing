boolean DEBUG = false;

int SIZE = 500;
int MARGIN = 25;
int FONTSIZE = 24;

//String FONTNAME = "LetterGothicStd-Bold";
String FONTNAME = "OratorStd";

int MINLEN = 3;
//int MAXLEN = SIZE/MARGIN; // fit to available space
int MAXLEN = 16;

int LETTERS_WIDE = SIZE/MARGIN;

String[] words;
StringList[] wordsByLength;
PFont f;

void setup() {
  size(SIZE, SIZE);
  background(0);
  stroke(255);

  rectMode(CENTER);

  words = loadDictionary("dict.txt");
  wordsByLength = buildListByLength(words);
  
//  printArray(PFont.list());
  f = createFont(FONTNAME, FONTSIZE, true);
  textFont(f);
  textAlign(CENTER, CENTER);
}

String[] loadDictionary(String fileName) {
  println("Loading dictionary [" + fileName + "]");
  int start = millis(); 
  String[] words = loadStrings(fileName);
  println("...finished in " + (millis() - start) + " ms");

  return words;
}

StringList[] buildListByLength(String[] words) {
  StringList[] wordsByLength = new StringList[MAXLEN + 1];
  for (int i = 1; i <= MAXLEN; i++) { 
    wordsByLength[i] = new StringList();
  }

  for (String word : words) {
    if (word.indexOf("%") >= 0) {
      word = word.substring(0, word.length()-1); 
    }
    if (word.length() > MAXLEN) { continue; }
    
    wordsByLength[word.length()].append(word.toLowerCase());
  }
  
  return wordsByLength;
}

void draw() {
  background(0);
  translate(MARGIN/2, MARGIN/2);
  
  int currLen, wordIndex, gridIndex, left;
  StringList currList;
  String currWord;
  
  
  for (int y = 0; y <= height-MARGIN; y += MARGIN) {
    left = LETTERS_WIDE;
    gridIndex = 0;
    
    while(left > 1) {
      currLen = int(random(min(MINLEN, left), min(MAXLEN+1, left+1)));
      currList = wordsByLength[currLen];
      wordIndex = int(random(currList.size()));
      
//      println(currLen, wordIndex);
      
      currWord = currList.remove(wordIndex);
      
      for (int i = gridIndex; i < gridIndex + currLen; i++) {
        text(currWord.charAt(i-gridIndex), i*MARGIN, y);
        
        if (DEBUG) {
          pushStyle();
          stroke(255,255,0);
          noFill();
          rect(i*MARGIN, y, MARGIN, MARGIN);
          popStyle();
        }
      }
      
      if (DEBUG) {
        println(currWord);
      }
      
      gridIndex += currLen + 1;
      left = LETTERS_WIDE - gridIndex;
    }
  }
  noLoop();
}

void mouseClicked() {
  wordsByLength = buildListByLength(words);
  loop();
}

