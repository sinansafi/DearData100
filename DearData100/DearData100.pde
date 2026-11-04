ArrayList<Observation> observations = new ArrayList<Observation>();
Observation selected = null;

// Category colours
color transport = color(65, 125, 180);
color nature = color(91, 145, 100);
color people = color(174, 112, 151);
color animals = color(220, 153, 65);

void setup() {
  size(1000, 700);
  smooth();
  surface.setTitle("Walking Through the Ordinary");
  loadData();
}

void draw() {
  background(247, 243, 232);

  drawHeading();
  drawLegend();
  drawRoute();
  drawObservations();
  drawPanel();
}

// ADD OBSERVATIONS

void loadData() {
  addObservation(1, "23-10-2026", "transport", "Bicycle locked on railing");
  addObservation(2, "23-10-2026", "nature", "Yellow leaves on tree");
  addObservation(3, "23-10-2026", "people", "Person walking with football");
  addObservation(4, "23-10-2026", "animals", "Squirrel climbing tree");
  addObservation(5, "25-10-2026", "people", "Person jogging in park");
  addObservation(6, "25-10-2026", "nature", "Fallen leaves on pavement");
  addObservation(7, "25-10-2026", "transport", "Car parked on street");
  addObservation(8, "26-10-2026", "people", "Person sitting on a bench");
  addObservation(9, "26-10-2026", "nature", "Fallen branch on ground");
  addObservation(10, "26-10-2026", "transport", "Bus at bus stop");
  addObservation(11, "26-10-2026", "transport", "Car at traffic light");
  addObservation(12, "26-10-2026", "animals", "Bird sitting on tree branch");
  addObservation(13, "31-10-2026", "people", "Person running with headphones");
  addObservation(14, "31-10-2026", "nature", "Clouds covering the sky");
  addObservation(15, "31-10-2026", "transport", "Bicycle leaning against wall");
  addObservation(16, "31-10-2026", "animals", "Bird walking on pavement");
  addObservation(17, "03-11-2026", "people", "Person carrying shopping bags");
  addObservation(18, "03-11-2026", "nature", "Plants growing beside wall");
  addObservation(19, "03-11-2026", "transport", "Car parked in driveway");
  addObservation(20, "03-11-2026", "animals", "Cat walking on pavement");
}

void addObservation(int id, String date, String category, String description) {
  observations.add(new Observation(id, date, category, description));
}

// HEADING

void drawHeading() {
  fill(47, 58, 47);
  textAlign(LEFT);
  textSize(30);
  text("WALKING THROUGH", 40, 55);
  text("THE ORDINARY.", 40, 88);

  fill(120);
  textSize(13);
  text("A visual diary of everyday observations", 42, 115);

  stroke(190, 180, 159);
  line(40, 140, 960, 140);
  noStroke();
}

// CATEGORY LEGEND

void drawLegend() {
  drawLegendItem(transport, "TRANSPORT", 55, 175);
  drawLegendItem(nature, "NATURE", 220, 175);
  drawLegendItem(people, "PEOPLE", 350, 175);
  drawLegendItem(animals, "ANIMALS", 470, 175);
}

void drawLegendItem(color c, String label, int x, int y) {
  fill(c);
  ellipse(x, y, 12, 12);

  fill(60);
  textSize(11);
  textAlign(LEFT);
  text(label, x + 12, y + 4);
}

// WALKING ROUTE

float getX(int i) {
  return 65 + (i % 5) * 130;
}

float getY(int i) {
  return 240 + (i / 5) * 100;
}

void drawRoute() {
  stroke(210, 199, 178);
  strokeWeight(3);
  noFill();

  for (int i = 0; i < observations.size() - 1; i++) {
    line(getX(i), getY(i), getX(i + 1), getY(i + 1));
  }

  strokeWeight(1);
  noStroke();
}

// DISPLAY OBSERVATIONS

void drawObservations() {
  for (int i = 0; i < observations.size(); i++) {
    Observation item = observations.get(i);

    item.x = getX(i);
    item.y = getY(i);

    item.display();
  }
}

// CATEGORY COLOURS

color categoryColour(String category) {
  if (category.equals("transport")) return transport;
  if (category.equals("nature")) return nature;
  if (category.equals("people")) return people;
  if (category.equals("animals")) return animals;

  return color(130);
}

// CATEGORY STATISTICS

int countCategory(String category) {
  int total = 0;

  for (Observation item : observations) {
    if (item.category.equals(category)) {
      total++;
    }
  }

  return total;
}

// DETAILS PANEL

void drawPanel() {
  fill(255, 252, 243);
  noStroke();
  rect(730, 210, 230, 390, 12);

  fill(47, 58, 47);
  textSize(16);
  textAlign(LEFT);
  text("FIELD NOTES", 750, 245);

  textSize(32);
  text(observations.size(), 750, 290);

  fill(120);
  textSize(10);
  text("TOTAL OBSERVATIONS", 752, 310);

  drawStat("TRANSPORT", transport, countCategory("transport"), 350);
  drawStat("NATURE", nature, countCategory("nature"), 385);
  drawStat("PEOPLE", people, countCategory("people"), 420);
  drawStat("ANIMALS", animals, countCategory("animals"), 455);

  stroke(210, 200, 181);
  line(750, 480, 940, 480);
  noStroke();

  if (selected != null) {
    drawSelected();
  }
}

void drawStat(String label, color c, int total, int y) {
  fill(c);
  ellipse(755, y - 4, 9, 9);

  fill(70);
  textSize(10);
  textAlign(LEFT);
  text(label, 770, y);

  textAlign(RIGHT);
  text(total, 930, y);
}

// SELECTED OBSERVATION

void drawSelected() {
  fill(categoryColour(selected.category));
  textAlign(LEFT);
  textSize(11);
  text("OBSERVATION #" + selected.id, 750, 515);

  fill(47, 58, 47);
  textSize(14);
  text(selected.category.toUpperCase(), 750, 545);

  fill(120);
  textSize(11);
  text(selected.date, 750, 570);

  fill(60);
  textSize(12);
  text(selected.description, 750, 580, 190, 45);
}

// CLICK INTERACTION

void mousePressed() {
  selected = null;

  for (Observation item : observations) {
    if (dist(mouseX, mouseY, item.x, item.y) < 22) {
      selected = item;
      break;
    }
  }
}

// OBSERVATION CLASS

class Observation {
  int id;
  String date;
  String category;
  String description;

  float x, y;

  Observation(int id, String date, String category, String description) {
    this.id = id;
    this.date = date;
    this.category = category;
    this.description = description;
  }

  void display() {
    color accent = categoryColour(category);

    if (selected == this) {
      fill(accent, 70);
      noStroke();
      ellipse(x, y, 50, 50);
    }

    fill(255);
    noStroke();
    ellipse(x, y, 36, 36);

    fill(accent);
    ellipse(x, y, 27, 27);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(11);
    text(id, x, y);
  }
}
