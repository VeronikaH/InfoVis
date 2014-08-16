public class Overview
{
  int x;
  int y;
  float oWidth;
  float oHeight;
  boolean mouseInside = false;
  ArrayList<Diagram> diagrams;
  
  public Overview(int x, int y, float oWidth, float oHeight)
  {
    this.x = x;
    this.y = y;
    this.oWidth = oWidth;
    this.oHeight = oHeight;
  }
  
  void drawOverview(ArrayList<DataRecord> dataRecords, ArrayList<Diagram> diagrams)
  {
    fill(120);
    stroke(120);
    rect(x, y, oWidth, oHeight);
    
    this.diagrams = diagrams;
    int startX = 25;
    int maxRadius = 40;
    int posX = startX + maxRadius/2;
    int posY = 40;
    int circlesDrawn = 0;
    int circlesInRow = 6;
    int age = 5;
    
    for (DataRecord dr : dataRecords)
    {
      if (circlesDrawn != 0 && circlesDrawn%circlesInRow == 0)
      {
        posX = startX + maxRadius/2;
        posY += maxRadius + 5;
      }
      if (diagrams.isEmpty())
      {
        initDiagrams(dataRecords, maxRadius, 1, posX, posY);
      }
      else
      {
        fill(200);
        stroke(200);
        int index = dataRecords.indexOf(dr);
        Diagram d = diagrams.get(index);

        ArrayList<DiagramPart> dp1 = d.getDiagram1();
        ArrayList<DiagramPart> dp2 = d.getDiagram2();
        ArrayList<DiagramPart> dp3 = d.getDiagram3();
        
        drawDiagram(3, posX, posY, dp3);
        drawDiagram(2, posX, posY, dp2);
        drawDiagram(1, posX, posY, dp1);
        
        fill(255);
        textSize(10);
        text(String.valueOf(age),posX-3,posY);
        textSize(15);
        //text("Jahre",posX-17,posY+10);
        age++;
        
        posX += maxRadius + 5;
        circlesDrawn++;

      }
    }
  }
  
  void initDiagrams(ArrayList<DataRecord> dataRecords, float maxRadius, int choice, float x, float y)
  {
    for (DataRecord d: dataRecords)
    {
      Diagram newDiagram = new Diagram(d, maxRadius, choice, x,y);
      diagrams.add(newDiagram);
    } 
  }
  
  void drawDiagram(int level, float x, float y, ArrayList<DiagramPart> dp)
  {
    int colorIndex1, colorIndex2;
    noStroke();
    if (level == 3)
    {
      for (DiagramPart p: dp)
      {
        if (p != null)
        {
          colorIndex1 = sc.getSectorIndex(dp.indexOf(p));
          colorIndex2 = sc.getSectorIndex(colorIndex1, dp.indexOf(p));
          if ((colorIndex1 >= 0) && colorIndex2 >= 0)
          {
            fill(sc.getSchoolColor(colorIndex1, colorIndex2));
            arc(x, y, 35, 35, p.getAngle1(), p.getAngle2(), PIE);
          }
        }
      }
    }
    
    if (level == 2) 
    {
      int c = 100;
      for (DiagramPart p: dp)
      {
        if (p != null)
        {
          colorIndex1 = dp.indexOf(p);
          
          if (colorIndex1 >= 0)
            fill(sc.getSchoolColor(colorIndex1));
          else
            fill(c);
          arc(x, y, 25, 25, p.getAngle1(), p.getAngle2(), PIE);
        }
      }
    }
    if (level == 1)
    {
      for (DiagramPart p: dp)
      {
        fill(200);
        arc(x, y, 15, 15, p.getAngle1(), p.getAngle2(), PIE);
      }
    }
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
