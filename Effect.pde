class Effect
{
  float x, y, z;
  float xMover, yMover, zMover, speed;
  float size, sizeChanger;
  float hue;

  public Effect(float x, float y, float z, float hue)
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

  public Effect(Effect temp)
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
