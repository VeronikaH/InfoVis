public class Button
{
  String text;
  int x;
  int y;
  int bWidth;
  int bHeight;
  
  Button(String text, int x, int y, int bWidth, int bHeight)
  {
    this.text = text;
    this.x = x;
    this.y = y;
    this.bWidth = bWidth;
    this.bHeight = bHeight;
  }
  
  void drawButton()
  {
    if (mouseX > x && mouseX < x+width && mouseY > y && mouseY < y+height)
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
    textSize(22);
    text(text,width-90,height-45);
  }

}
