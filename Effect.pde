class Effect
{
  PVector loc,vel;
  float speed, size, sizeChanger, hue;

  //Pre explosion
  public Effect(float x, float y, float z, float hue)
  {
    loc = new PVector(x,y,z);
    vel = new PVector(random(-5, 5),random(-25, -15),random(-5, 5));
    this.hue = hue;
    speed = .1;
    size = 10;
    sizeChanger = .1;
  }

  //Post explosion
  public Effect(Effect temp)
  {
    loc = new PVector(temp.loc.x,temp.loc.y,temp.loc.z);
    vel = new PVector(random(-12, 12),random(-12, 12),random(-12, 12));
    hue = temp.hue;
    size = random(10, 15);
    sizeChanger = .20;
  }

  //Render single sphere
  void render()
  {
    noStroke();
    fill(hue, 255, 255);
    pushMatrix();
    translate(loc.x,loc.y,loc.z);
    sphere(size);
    popMatrix();
    loc.add(vel);
    vel.y += speed;
    size -= sizeChanger;
  }

  boolean isDead()
  {
    return size <= 0;
  }
}
