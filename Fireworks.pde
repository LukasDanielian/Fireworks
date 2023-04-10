ArrayList<Ball> balls;
ArrayList<Ball> streaks;
ArrayList<PVector> stars;
PVector snapBack;
float lookX;
float lookY;
float lookZ;

void setup()
{
  fullScreen(P3D);
  shapeMode(CENTER);
  textAlign(CENTER, CENTER);
  sphereDetail(5);
  colorMode(HSB);

  balls = new ArrayList<Ball>();
  streaks = new ArrayList<Ball>();
  stars = new ArrayList<PVector>();
  lookX = 0;
  lookY = height * .75;
  lookZ = -width/2;

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

  if (balls.size() > 0)
  {
    lookX = balls.get(0).x;
    lookY = (height * .75) + balls.get(0).y - width;
    lookZ = (-width/2) + balls.get(0).z;
  } 
  
  else if (streaks.size() == 0)
  {
    lookX = 0;
    lookY = height * .75;
    lookZ = -width/2;
  }

  perspective(PI/2, float(width)/height, 0.01, width * 3);
  camera(0, height * .7, 0, lookX, lookY, lookZ, 0, 1, 0);
  
  for(int i = 0; i < stars.size(); i++)
  {
    pushMatrix();
    translate(stars.get(i).x,stars.get(i).y,stars.get(i).z);
    fill(255);
    sphere(3);
    popMatrix();
  }

  pushMatrix();
  translate(0, height * .75, -width/2);
  fill(100, 255, 50);
  box(width * 3, 1, width);
  popMatrix();

  if (frameCount % 250 == 0)
    balls.add(new Ball(0, height * .75, -width/2, random(0, 255)));

  for (int i = 0; i < balls.size(); i++)
  {
    Ball temp = balls.get(i);
    temp.render();

    if (temp.isDead())
    {
      for (int j = 0; j < random(100, 200); j++)
        streaks.add(new Ball(temp));

      balls.remove(i);
      i--;
    }
  }

  for (int i = 0; i < streaks.size(); i++)
  {
    Ball temp = streaks.get(i);
    temp.render();

    if (temp.isDead())
    {
      streaks.remove(i);
      i--;
    }
  }
}

class Ball
{
  float x, y, z;
  float xMover, yMover, zMover, speed;
  float size, sizeChanger;
  float hue;

  public Ball(float x, float y, float z, float hue)
  {
    this.x = x;
    this.y = y;
    this.z = z;
    this.hue = hue;
    xMover = random(-5, 5);
    yMover = random(-25, -15);
    zMover = random(-5, 5);
    speed = .1;
    size = 10;
    sizeChanger = .1;
  }

  public Ball(Ball temp)
  {
    x = temp.x;
    y = temp.y;
    z = temp.z;
    hue = temp.hue;
    xMover = random(-12, 12);
    yMover = random(-12, 12);
    zMover = random(-12, 12);
    size = random(10, 15);
    sizeChanger = .25;
  }

  void render()
  {
    noStroke();
    fill(hue, 255, 255);
    pushMatrix();
    translate(x, y, z);
    sphere(size);
    popMatrix();
    x += xMover;
    y += yMover;
    z += zMover;
    yMover += speed;
    size -= sizeChanger;
  }

  boolean isDead()
  {
    return size <= 0;
  }
}
