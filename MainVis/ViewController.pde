import java.lang.*;
import javax.swing.*;

public class ViewController
{
  ArrayList<DataRecord> dataRecords;
  ArrayList<DataRecord> selectedDataRecords;
  int viewModus = 1; // 1 -> Übersicht ist groß, Auswahl einzelner Kreise möglich; 2 -> Overviewfenster, Legende, Dropdownmenu
  //Legend legend;
  //DropDownMenu menu;
  Button buttonF = new Button("Fertig",width-100,height-80,80,50,null);
  Button buttonG = new Button("Gesamt",width-100,10,80,50,"gesamt.png");
  Button buttonGg = new Button("Geschlechtergetrennt",width-100,62,80,50,"getrennt.png");
  Button buttonM1 = new Button("1",20,80,40,50,null);
  Button buttonM2 = new Button("2",20,132,40,50,null);
  Button buttonM3 = new Button("3",20,184,40,50,null);
  boolean firstRun = true;
  
  
  ViewController(ArrayList<DataRecord> dataRecords) 
  {
    this.dataRecords = dataRecords;
    this.selectedDataRecords = dataRecords; // zu Beginn soll alles angezeigt werden 
  }
  
  void setup()
  {
  }
  
  
  void draw()
  {
    
    if (viewModus == 1)
    {
      if (firstRun) 
      {
        drawLittleCircles();
        drawHeadlinesView1();
        firstRun = false;
      }
      buttonF.update();
      buttonM1.update();
      buttonM2.update();
      buttonM3.update();
      if (buttonF.mouseInside && mousePressed) // Klick auf Fertig-Button
      {
        buttonF.activated = true;
        viewModus = 2;
        firstRun = true;
      }
      else if (buttonM1.mouseInside && mousePressed) // Klick auf Button Zoomstufe 1
      {
        buttonM2.deactivate();
        buttonM3.deactivate();
        buttonM1.activate();
      }
      else if (buttonM2.mouseInside && mousePressed) // Klick auf Zoomstufe 2
      {
        buttonM3.deactivate();
        buttonM1.deactivate();
        buttonM2.activate();
      }
      else if (buttonM3.mouseInside && mousePressed) // Klick auf Zoomstufe 3
      {
        buttonM1.deactivate();
        buttonM2.deactivate();
        buttonM3.activate();
      }
    }
    
    else if (viewModus == 2)
    {
      if (firstRun)
      {
        background(60);
        drawOverview();
        drawHeadlinesView2();
        firstRun = false;
      }
      buttonG.update();
      buttonGg.update();
      if (buttonG.mouseInside && mousePressed)
      {
        buttonGg.deactivate();
        buttonG.activate();
      }
      else if (buttonGg.mouseInside && mousePressed)
      {
        buttonG.deactivate();
        buttonGg.activate();
      }
    }
  }

  void drawLittleCircles()
  {
    int startX = 200; // falls Seitenleiste hinzukommt, hier Breite abziehen
    int startY = 100;
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
      fill(200);
      stroke(200);
      ellipse(posX,posY,maxRadius-20,maxRadius-20);
      posX += maxRadius;
      circlesDrawn++;
    }
  }
  
  void drawHeadline()
  {
    fill(255);
    textSize(32);
    text("Schüler/-innen und Studierende nach Geschlecht,",320,50);
    text("Alter und Bildungsbereichen 2010",450,85);
  }
  
  void drawHeadlinesView1()
  {
    drawHeadline();
    
    fill(200);
    stroke(200);
    rect(20,20,150,40);
    fill(0);
    textSize(24);
    text("Zoomlevel",25,50);
    
    fill(200);
    rect(20,250,150,40);
    fill(0);
    text("Legende",25,280);
  }
  
  void drawOverview()
  {
    fill(120);
    stroke(120);
    rect(20,20,280,220);
    // TODO: Kreise zeichnen mit aktuell ausgewählten
  }
  
  void drawHeadlinesView2()
  {
    drawHeadline();
    
    stroke(200);
    fill(200);
    rect(20,250,150,40);
    fill(0);
    textSize(24);
    text("Legende",25,280);
  }
  
}
 
