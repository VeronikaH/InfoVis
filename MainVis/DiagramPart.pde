public class DiagramPart() 
{
  float centerX, centerY, radius;
  float angle1, angle2;
  float nAngle1, nAngle2;
  
  public DiagramPart(float x, float y, float radius, float angle1, float angle2)
  {
    this.centerX = x;
    this.centerY = y;
    this.radius = radius;
    this.angle1 = angle1;
    this.angle2 = angle2;
    this.nAngle1 = normalizeAngle(angle1);
    this.nAngle2 = normalizeAngle(angle2);
  }
  
  public float getCenterX() 
  {
    return this.centerX;
  }
  
  public float getCenterY() 
  {
    return this.centerY;
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
  
  boolean mouseInside(int x, int y) {
    if (sqrt(pow(x-centerX,2) - pow(y-centerY,2)) <= d) 
    {
      float a = normalizeAngle(atan2(y-centerY, x-centerX));
      boolean b = (nAngle1<=a)&&(a<=nAngle2);
      if (nAngle1 < nAngle2)
        return b;
      else
        return !b;  
    }
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

