public class Overview
{
  int x;
  int y;
  int oWidth;
  int oHeight;
  boolean mouseInside = false;
  
  public Overview(int x, int y, int oWidth, int oHeight)
  {
    this.x = x;
    this.y = y;
    this.oWidth = oWidth;
    this.oHeight = oHeight;
  }
  
  void drawOverview()
  {
    fill(120);
    stroke(120);
    rect(x, y, oWidth, oHeight);
    // TODO: Kreise zeichnen mit aktuell ausgewählten
  }
  
  boolean mouseInside()
  {
    boolean newMouseInside = mouseX > x && mouseX < x+oWidth && mouseY > y && mouseY < y+oHeight;
    if (newMouseInside && !mouseInside)
    {
      cursor(HAND);
      mouseInside = true;
    }
    else if (!newMouseInside && mouseInside)
    {
      cursor(ARROW);
      mouseInside = false;
    }
    
    return mouseInside;
  }
}
