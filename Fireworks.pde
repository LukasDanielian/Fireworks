ArrayList<Effect> balls;
ArrayList<Effect> streaks;
ArrayList<PVector> stars;
PVector snapBack;
float lookX;
float lookY;
float lookZ;

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
  lookX = 0;
  lookY = height * .75;
  lookZ = -width/2;

  //Set location for stars
  for (int i = 0; i < 1000; i++)
  {
    float x = random(-width * 2, width * 2);
    float y = random(-width * 2, width * 2);
    float z = random(-width * 2, width * 2);
    float dist = dist(0, 0, 0, x, y, z);

    while (dist < width * 1.5 || dist > width * 2)
    {
      x = random(-width * 2, width * 2);
      y = random(-width * 2, width  * 2);
      z = random(-width * 2, width * 2);
      dist = dist(0, 0, 0, x, y, z);
    }
    
    stars.add(new PVector(x,y,z));
  }
}

void draw()
{
  background(0);

  //Point at firework
  if (balls.size() > 0)
  {
    lookX = balls.get(0).x;
    lookY = (height * .75) + balls.get(0).y - width;
    lookZ = (-width/2) + balls.get(0).z;
  } 
  
  //Point at ground
  else if (streaks.size() == 0)
  {
    lookX = 0;
    lookY = height * .75;
    lookZ = -width/2;
  }

  //Set camera
  perspective(PI/2, float(width)/height, 0.01, width * 3);
  camera(0, height * .7, 0, lookX, lookY, lookZ, 0, 1, 0);
  
  //Render stars
  for(int i = 0; i < stars.size(); i++)
  {
    pushMatrix();
    translate(stars.get(i).x,stars.get(i).y,stars.get(i).z);
    fill(255);
    sphere(3);
    popMatrix();
  }

  //Grass floor
  pushMatrix();
  translate(0, height * .75, -width/2);
  fill(100, 255, 50);
  box(width * 3, 1, width);
  popMatrix();

  //Launch firework
  if (frameCount % 250 == 0)
    balls.add(new Effect(0, height * .75, -width/2, random(0, 255)));

  //Render all launch particles
  for (int i = 0; i < balls.size(); i++)
  {
    Effect temp = balls.get(i);
    temp.render();

    if (temp.isDead())
    {
      for (int j = 0; j < random(100, 200); j++)
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
