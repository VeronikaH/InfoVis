public class Button
{
  String text;
  int x;
  int y;
  int bWidth;
  int bHeight;
  boolean mouseInside = true;
  boolean activated = false;
  String image;
  PImage icon;
  
  Button(String text, int x, int y, int bWidth, int bHeight, String image)
  {
    this.text = text;
    this.x = x;
    this.y = y;
    this.bWidth = bWidth;
    this.bHeight = bHeight;
    this.image = image;
  }
  
  void drawButton()
  {
    strokeWeight(2);
    fill(200);
    rect(x,y,bWidth,bHeight,7);
    fill(0);
    if (image != null)
    {
      icon = loadImage(image);
      image(icon,x-5,y,bWidth+10,bHeight);
    }
    else
    {
      textSize(22);
      text(text,x+10,y+35);
    }
  }
  
  boolean mouseInside()
  {
    if (mouseX > x && mouseX < x+bWidth && mouseY > y && mouseY < y+bHeight) {
      mouseInside = true;
      return true;
    }
    mouseInside = false;
    return false;
    
  }
  
  void update()
  {
    boolean newMousePos = mouseX > x && mouseX < x+bWidth && mouseY > y && mouseY < y+bHeight;
    if (!mouseInside && newMousePos)
    {
      mouseInside = true;
      stroke(255);
      cursor(HAND);
      drawButton();
    }
    else if (mouseInside && !newMousePos && !activated)
    {
      mouseInside = false;
      stroke(0);
      cursor(ARROW);
      drawButton();
    }
    
  }
  
  void activate()
  {
    if (!activated)
    {
      activated = true;
      stroke(255);
      cursor(ARROW);
      drawButton();
    }
  }
  
  void deactivate()
  {
    if (activated)
    {
      activated = false;
      stroke(0);
      cursor(ARROW);
      drawButton();
    }
  }

}
