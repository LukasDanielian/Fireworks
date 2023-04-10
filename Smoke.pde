class Smoke
{
  PVector loc;
  float size;
  
  public Smoke(PVector loc)
  {
    this.loc = new PVector(loc.x + random(-7,7),loc.y + random(50,65),loc.z + random(-7,7));
    size = 10;
  }
  
  void render()
  {
    pushMatrix();
    translate(loc.x,loc.y,loc.z);
    fill(30,255,map(size, 10, 0, 255,0));
    sphere(size);
    popMatrix();
    
    size -= 1;
  }
  
  boolean isDead()
  {
    return size <= 0;
  }
}
