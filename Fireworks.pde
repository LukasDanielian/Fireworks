ArrayList<Effect> balls;
ArrayList<Effect> streaks;
ArrayList<PVector> stars;
PVector look;
Planet moon;
Planet venus;

void setup()
{
  //Settings
  fullScreen(P3D);
  shapeMode(CENTER);
  textAlign(CENTER, CENTER);
  sphereDetail(5);
  colorMode(HSB);

  balls = new ArrayList<Effect>();
  streaks = new ArrayList<Effect>();
  stars = new ArrayList<PVector>();
  look = new PVector(0, height * .75, -width/2);
  moon = new Planet(PI,"moon.jpg");
  venus = new Planet(0,"venus.jpg");

  //Set location for stars
  for (int i = 0; i < 1000; i++)
  {
    PVector temp;
    float dist;
    
    do
    {
      temp = new PVector(random(-width * 3, width * 3),random(-width * 3, width * 3),random(-width * 3, width * 3));
      dist = dist(0, 0, 0, temp.x, temp.y, temp.z);
    }
    while (dist < width * 2.5 || dist > width * 3);

    stars.add(temp);
  }
}

void draw()
{
  background(0);

  setCamera();
  renderWorld();
  renderEffects();

  //Launch firework
  if (frameCount % 250 == 0)
  {
    for (int i = 0; i < random(1, 10); i++)
      balls.add(new Effect(0, height * .75, -width/2, random(0, 255)));
  }
}

//Sets the viewing point
public void setCamera()
{
  //Finds midpoint
  if (balls.size() > 0)
  {
    PVector total = new PVector(0, 0, 0);

    for (int i = 0; i < balls.size(); i++)
      total.add(balls.get(i).loc);

    look = total.div(balls.size());
  } 
  
  //Looks at base
  else if (streaks.size() == 0)
    look = new PVector(0, height * .75, -width/2);

  perspective(PI/2, float(width)/height, 0.01, width * 3);
  camera(0, height * .7, 0, look.x, look.y, look.z, 0, 1, 0);
}

//Renders all background items
public void renderWorld()
{
  //Render stars
  for (int i = 0; i < stars.size(); i++)
  {
    pushMatrix();
    translate(stars.get(i).x, stars.get(i).y, stars.get(i).z);
    fill(255);
    sphere(3);
    popMatrix();
  }
  
  //Render planets
  moon.render();
  venus.render();

  //Grass floor
  pushMatrix();
  translate(0, height * .75, -width/2);
  fill(100, 255, 50);
  box(width * 4, 1, width);
  popMatrix();
}

//Renders all effects from firework
public void renderEffects()
{
  //Render all launch particles
  for (int i = 0; i < balls.size(); i++)
  {
    Effect temp = balls.get(i);
    temp.render();

    if (temp.isDead())
    {
      for (int j = 0; j < 300; j++)
        streaks.add(new Effect(temp));

      balls.remove(i);
      i--;
    }
  }

  //Render exsplosive particles
  for (int i = 0; i < streaks.size(); i++)
  {
    Effect temp = streaks.get(i);
    temp.render();

    if (temp.isDead())
    {
      streaks.remove(i);
      i--;
    }
  }
}
