public class Legend
{
  Legend() {}
  
  void drawLegend(int viewModus)
  {
    if (activeButtonZoom == null) return;
    
    int x = 10;
    int y = 210;
    if (viewModus == 2)
      y = 300;
    stroke(0);
    strokeWeight(1);
    fill(200);
    rect(x,y,15,15,7);
    textSize(20);
    if (viewModus == 2)
      textSize(19);
    text("Schüler & Studenten",x+20,y+15);
    y += 35;
    x = 15;
    if (activeButtonZoom.equals("2") || activeButtonZoom.equals("3"))
    {
      for (int i = 0; i  < sc.getNumberOfSectors(); ++i)
      {
        fill(sc.getSchoolColor(i));
        rect(x,y,15,15,7);
        textSize(18);
        if (viewModus == 2)
          textSize(17);
        text(sc.getSchoolName(i),x+20,y+15);
        if (viewModus == 1)
          y += 25;
        else
          y += 21;
        if (activeButtonZoom.equals("3"))
        {
          for (int j = 0; j < sc.getNumberOfSchools(i); ++j)
          {
            x = 20;
            fill(sc.getSchoolColor(i,j));
            rect(x,y,10,10,7);
            textSize(15);
            text(sc.getSchoolName(i,j),x+20,y+12);
            if (viewModus == 1)
              y += 20;
            else
              y += 18;
          }
          x = 15;
          y += 10;
        }
      }
    }
  }
  
}
