public class Legend
{
  int tagDiagram;
  int tagSector;
  int tagSchool;
  
  Legend() 
  {
    tagDiagram = -1;
    tagSector = -1;
    tagSchool = -1;
  }
  
  void drawLegend(int viewModus)
  {
    if (activeButtonZoom == null) return;
    int x = 10;
    int y = 300;
    stroke(0);
    strokeWeight(1);
    fill(200);
    rect(x,y,15,15,7);
    
    if (tagDiagram > 0)
    {
      stroke(255);
      strokeWeight(2);
      rect(x,y,15,15,7);
      fill(255);
      strokeWeight(1);
    }
    
    textSize(19);
    text("Schüler & Studenten",x+20,y+15);
    y += 35;
    x = 15;
    if (activeButtonZoom.equals("2") || activeButtonZoom.equals("3"))
    {
      for (int i = 0; i  < sc.getNumberOfSectors(); ++i)
      {
        stroke(0);
        fill(sc.getSchoolColor(i));
        rect(x,y,15,15,7);
        
        if (i == tagSector)
        {
          stroke(255);
          strokeWeight(2);
          rect(x,y,15,15,7);
          fill(255);
          strokeWeight(1);
        }
        
        textSize(17);
        text(sc.getSchoolName(i),x+20,y+15);
        y += 21;
        if (activeButtonZoom.equals("3"))
        {
          for (int j = 0; j < sc.getNumberOfSchools(i); ++j)
          {
            x = 20;
            stroke(0);
            fill(sc.getSchoolColor(i,j));
            rect(x,y,10,10,7);
            
            if ((i == tagSector)&&(j == tagSchool))
            {
              stroke(255);
              strokeWeight(2);
              rect(x,y,10,10,7);
              fill(255);
              strokeWeight(1);
            }
            
            textSize(15);
            text(sc.getSchoolName(i,j),x+20,y+12);
            y += 18;
          }
          x = 15;
          y += 10;
        }
      }
    }
  }
  
  void setTags(int a, int b, int c)
  {
    tagDiagram = a;
    tagSector = b; 
    tagSchool = c;
  }
  
  void setDiagramTag(int a)
  {
    tagDiagram = a;
  }
  
  void setSectorTag(int b)
  {
    tagSector = b; 
  }
  
  void setSchoolTag(int c)
  {
    tagSchool = c;
  }
  
  void resetTags()
  {
    tagDiagram = -1;
    tagSector = -1; 
    tagSchool = -1;
  }
  
  void resetDiagramTag()
  {
    tagDiagram = -1;
  }
  
  void resetSectorTag()
  {
    tagSector = -1;  
  }
  
  void resetSchoolTag()
  {
    tagSchool = -1;
  }
    
  
}
