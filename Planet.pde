class Planet
{
  PShape sphere;
  PVector loc;
  float size = 250;
  float theta;
  
  public Planet(float theta, String textureFile)
  {
    this.theta = theta;
    loc = new PVector(sin(theta) * (width * 2),(cos(theta) * (width * 2)) + height * .75,-width);
    sphereDetail(50);
    noStroke();
    noFill();
    sphere = createShape(SPHERE,size);
    sphere.setTexture(loadImage(textureFile));
    sphereDetail(5);
  }
  
  void render()
  {
    pushMatrix();
    translate(loc.x,loc.y,loc.z);
    shape(sphere);
    popMatrix();
    
    loc.x = (sin(theta) * (width * 2)) + size;
    loc.y = (cos(theta) * (width * 2)) + height * .75;
    theta += .01;
  }
}
