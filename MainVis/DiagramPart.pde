public class DiagramPart
{
  float radius, angle1, angle2;
  float nAngle1, nAngle2;
  
  public DiagramPart(float radius, float angle1, float angle2)
  {
    this.radius = radius;
    this.angle1 = angle1;
    this.angle2 = angle2;
    this.nAngle1 = normalizeAngle(angle1);
    this.nAngle2 = normalizeAngle(angle2);
  }
  
  public float getRadius() 
  {
    return this.radius;
  }
  
  public float getAngle1() 
  {
    return this.angle1;
  }
  
  public float getAngle2()
  {
    return this.angle2;
  }
  
  public void setRadius(float r) 
  {
    this.radius = r;
  }
  
  boolean mouseInside(float centerX, float centerY) 
  {
   boolean nearCenter = sqrt(sq(mouseX-centerX) - sq(mouseY-centerY)) < radius;
   float a = normalizeAngle(atan2(mouseY-centerY, mouseX-centerX));
   boolean between;
   if (nAngle1 < nAngle2)
     between = nAngle1 <= a && a <= nAngle2;
   else
     between = !(nAngle2 <= a && a <= nAngle1);

   if (nearCenter && between)
     return true;
   else
     return false;  
  }
  float normalizeAngle(float angle) 
  {
    float result = angle % (2 * PI);
    if (result < 0)
      result += 2 * PI;
    return result;
  }
}

