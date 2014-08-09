public class Button
{
  String text;
  int x;
  int y;
  int bWidth;
  int bHeight;
  boolean mouseInside = true;
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
    if (mouseInside)
    {
      stroke(255);
      cursor(HAND);
    }
    else 
    {
      stroke(0);
      cursor(ARROW);
    }
    strokeWeight(2);
    fill(180);
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
    if (mouseInside && !newMousePos)
    {
      mouseInside = false;
      drawButton();
    }
    else if (!mouseInside && newMousePos)
    {
      mouseInside = true;
      drawButton();
    }
    
  }

}
