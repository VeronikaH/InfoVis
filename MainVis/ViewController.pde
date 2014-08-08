import java.lang.*;
import javax.swing.*;

public class ViewController 
{
  ArrayList<DataRecord> dataRecords;
  ArrayList<DataRecord> selectedDataRecords;
  int viewModus = 1; // 1 -> Übersicht ist groß, Auswahl einzelner Kreise möglich; 2 -> Overviewfenster, Legende, Dropdownmenu
  //Legend legend;
  //DropDownMenu menu;
  Button button = new Button("Fertig",width-100,height-80,80,50);
  int buttonX;
  int buttonY;
  
  
  ViewController(ArrayList<DataRecord> dataRecords) 
  {
    this.dataRecords = dataRecords;
    this.selectedDataRecords = dataRecords; // zu Beginn soll alles angezeigt werden 
  }
  
  
  void draw()
  {
    
    if (viewModus == 1)
    {
      drawLittleCircles();
      button.drawButton();
    }
  }

  void drawLittleCircles()
  {
    int startX = 200; // falls Seitenleiste hinzukommt, hier Breite abziehen
    int startY = 50;
    int drawingWidth = width - startX; 
    int drawingHeight = height - startY;
    int circlesInRow = 7;
    int circlesInColumn = 4;
    int circlesDrawn = 0;
    float maxRadius = Math.min(drawingWidth/circlesInRow,drawingHeight/circlesInColumn);
    float posX = startX + maxRadius/2;
    float posY = startY + maxRadius/2;
    for (DataRecord dr : selectedDataRecords)
    {
      if (circlesDrawn != 0 && circlesDrawn%circlesInRow == 0)
      {
        posX = startX + maxRadius/2;
        posY += maxRadius;
      }
      // TODO: draw Circle(Point centre,float maxRadius,int level,bool grid)
      ellipse(posX,posY,maxRadius-20,maxRadius-20);
      posX += maxRadius;
      circlesDrawn++;
    }
  }
  
}
 
