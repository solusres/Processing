class Player {
  int x, y;
  String name;
  int score;

  public Player(int x, int y, String name) {
    this.x = x;
    this.y = y;
    this.name = name;
    this.score = 0;
  }

  void draw() {
    ellipse(x, y, 5, 5);
    text(name, x+3, y);
    text(score, x+3, y-textAscent());
  }
}
