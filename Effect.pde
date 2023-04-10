class Effect
{
  PVector loc, vel;
  float speed, size, sizeChanger, hue;
  ArrayList<Smoke> smoke;

  //Pre explosion
  public Effect(float x, float y, float z, float hue)
  {
    loc = new PVector(x, y, z);
    vel = new PVector(random(-10, 10), random(-50, -35), random(-10, 10));
    this.hue = hue;
    speed = .1;
    size = 10;
    sizeChanger = .1;
    smoke = new ArrayList<Smoke>();
  }

  //Post explosion
  public Effect(Effect temp)
  {
    loc = new PVector(temp.loc.x, temp.loc.y, temp.loc.z);
    hue = temp.hue;
    size = random(10, 15);
    sizeChanger = .20;
    
    do
    {
      vel = new PVector(random(-12, 12), random(-12, 12), random(-12, 12));
    }
    while(abs(vel.x) + abs(vel.z) > 20);
  }

  //Render single sphere
  void render()
  {
    noStroke();
    fill(hue, 255, 255);
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    sphere(size);
    popMatrix();
    loc.add(vel);
    vel.y += speed;
    size -= sizeChanger;

    if (smoke != null)
    {
      for(int i = 0; i < 5; i++)
        smoke.add(new Smoke(loc));

      for (int i = 0; i < smoke.size(); i++)
      {
        Smoke temp = smoke.get(i);
        temp.render();

        if (temp.isDead())
        {
          smoke.remove(i);
          i--;
        }
      }
    }
  }

  boolean isDead()
  {
    return size <= 0;
  }
}
