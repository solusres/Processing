abstract class Emotion {
  final int TEXT_PADDING = 5;
  final int TEXT_SIZE = 15;

  final float R_INPUT = 10;
  final color BLUE = #038BFF;
  final color LOW_BLUE = #034781;

  String title_en;
  String title_de;

  public Emotion() {
    textFont(createFont("Verdana", TEXT_SIZE));
  }

  void draw() {
    update();
    drawTitle();
    drawEmoter();
    drawStimulus();
  }

  abstract void update();

  void drawTitle() {
    pushStyle();
    fill(BLUE);
    text(title_en, width - textWidth(title_en) - TEXT_PADDING, height - textDescent() - TEXT_PADDING);
    text(title_de, width - textWidth(title_de) - TEXT_PADDING, height - (textDescent() + textAscent()) - TEXT_PADDING);
    popStyle();
  }

  void drawStimulus() {
    float factor = norm(sin(radians(frameCount*3)), -1, 1);
    
    pushStyle();
    fill(lerpColor(LOW_BLUE, BLUE, factor));
    ellipse(mouseX, mouseY, 2 * R_INPUT, 2 * R_INPUT);
    popStyle();
  }

  abstract void drawEmoter();
}
