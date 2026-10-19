void setup() {
  size(600, 600);
  background(248,245,237);
}

void draw() {
  background(248,245,237);
  
  fill(chooseColour(1));
  ellipse(150,150,40,40);
  
  fill(chooseColour(2));
  ellipse(250,200,40,40);
  
  fill(chooseColour(3));
  ellipse(350,250,40,40);
}

color chooseColour(int category) {
  if (category == 1) {
    return color(100,160,120);
  } else if (category == 2) {
    return color(220,150,90);
  } else {
    return color(120,140,200);
  }
}
