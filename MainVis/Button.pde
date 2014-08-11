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
    if (mouseX > x && mouseX < x+bWidth && mouseY > y && mouseY < y+bHeight)
      return true;
    return false;
    
  }
  
  void update()
  {
    boolean newMousePos = mouseX > x && mouseX < x+bWidth && mouseY > y && mouseY < y+bHeight;
    if (activeButton != null && !activeButton.equals(text)) // neuer Button wurde geklickt
      activated = false;
    if (!mouseInside && newMousePos && !activated) // Maus wird auf Button bewegt, Button noch nicht geklickt
    {
      mouseInside = true;
      cursor(HAND);
      stroke(255);
      drawButton();
    }
    else if (mouseInside && !newMousePos && !activated) // Maus verlässt Button, Button nicht geklickt
    {
      mouseInside = false;
      cursor(ARROW);
      stroke(0);
      drawButton();
    }
    else if (mouseInside && mousePressed) // Maus auf Button, Button wird geklickt
    {
      activated = true;
      activeButton = text;
      cursor(ARROW);
      stroke(255);
      drawButton();
    }
    else if (mouseInside && !newMousePos && activated) // Maus verlässt Button, Button geklickt
    {
      //do nothing
    }
    
  }

}
