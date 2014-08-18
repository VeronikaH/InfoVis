import java.lang.*;
import javax.swing.*;

public class ViewController
{
  ArrayList<DataRecord> dataRecords;
  ArrayList<DataRecord> selectedDataRecords;
  int viewModus = 1; // 1 -> Übersicht ist groß, Auswahl einzelner Kreise möglich; 2 -> Overviewfenster, Legende, Dropdownmenu, Gesamt; 3 -> wie 2, aber geschlechtergetrennt
  Legend legend = new Legend();
  Button buttonF = new Button("Fertig",width-100,height-80,80,50,null,false);
  Button buttonG = new Button("Gesamt",width-100,10,80,50,"gesamt.png",true);
  Button buttonGg = new Button("Geschlechtergetrennt",width-100,62,80,50,"getrennt.png",false);
  Button buttonM1 = new Button("1",20,80,40,50,null,true);
  Button buttonM2 = new Button("2",65,80,40,50,null,false);
  Button buttonM3 = new Button("3",110,80,40,50,null,false);
  Overview overview = new Overview(20,20,280,220);
  boolean firstRun = true;
  ArrayList<Diagram> diagrams;
  
  
  ViewController(ArrayList<DataRecord> dataRecords) 
  {
    this.dataRecords = dataRecords;
    this.selectedDataRecords = dataRecords; // zu Beginn soll alles angezeigt werden 
    this.diagrams = new ArrayList<Diagram>();
  }
  
  void drawInterface()
  {
    
    if (viewModus == 1)
    {
      if (firstRun) 
      {
        background(60);
        drawLittleCircles();
        drawHeadlinesView1();
        legend.drawLegend(1);
        buttonF.initiateLeft();
        buttonM1.initiateLeft();
        buttonM2.initiateLeft();
        buttonM3.initiateLeft();
        firstRun = false;
      }
      buttonF.updateLeft();
      buttonM1.updateLeft();
      buttonM2.updateLeft();
      buttonM3.updateLeft();
      if (activeButtonChanged) {
        firstRun = true;
        activeButtonChanged = false;
      }
      if (buttonF.mouseInside && mousePressed) // Klick auf Fertig-Button
      {
        viewModus = 2;
        firstRun = true;
      }
    }
    
    else 
    {
      if (firstRun)
      {
        background(60);
        overview.drawOverview(dataRecords,diagrams);
        drawHeadlinesView2();
        legend.drawLegend(2);
        buttonG.initiateRight();
        buttonGg.initiateRight();
        firstRun = false;
        if (viewModus == 2)
        {
          //drawBigCircle(500.0, 3);
          fill(255); 
          textSize(22);
          text("Gesamt",750,750);
        }
        else if (viewModus == 3)
        {
          fill(255);
          stroke(255);
          strokeWeight(2);
          line(800,250,800,700);
          
          //drawGenderCircle(400.0,1,3);
          //drawGenderCircle(400.0,2,3);
          
          textSize(22);
          text("Männer",width/4 +100,750);
          text("Frauen",3 * (width/4)-100,750);
        }
      }
      buttonG.updateRight();
      buttonGg.updateRight();
      if (overview.mouseInside() && mousePressed) // Klick auf Overview-Fenster
      {
        viewModus = 1;
        firstRun = true;
      }
      else if (buttonGg.mouseInside && mousePressed)
      {
        viewModus = 3;
        firstRun = true;
      }
      else if (buttonG.mouseInside && mousePressed)
      {
        viewModus = 2;
        firstRun = true;
      }
      if (viewModus == 2)
      {
        // update big circle when clicked
        drawBigCircle(500.0, 3);
      }
      else if (viewModus == 3)
      {
        // update two big circles when clicked
        drawGenderCircle(400.0,1,3);
        drawGenderCircle(400.0,2,3);
      }
    }
  }
  
  void drawGenderCircle(float maxRadius, int gender, int level)
  {
    float posX,posY;
    Diagram d;
    if (gender == 1)
    {
      posX = width/4 + 220;
      posY = height/2;
      d = new Diagram(dataRecords, maxRadius, 2, posX, posY);
    }
    else
    {
      posX = 3 * (width/4) + 20;
      posY = height/2;
      d = new Diagram(dataRecords, maxRadius, 3, posX, posY);
    }
    
    ArrayList<DiagramPart> dp1 = d.getDiagram1();
    ArrayList<DiagramPart> dp2 = d.getDiagram2();
    ArrayList<DiagramPart> dp3 = d.getDiagram3();
    
    if (level == 3)
    {
      drawDiagram(3, posX, posY, dp3);
      drawDiagram(2, posX, posY, dp2);
      drawDiagram(1, posX, posY, dp1);
    }
    if (level == 2)
    {
      drawDiagram(2, posX, posY, dp2);
      drawDiagram(1, posX, posY, dp1);
    }
    if (level == 1)
    {
      drawDiagram(1, posX, posY, dp1);
    }     
  
  }
  
  // TODO selectedDataRecords
  void drawBigCircle(float maxRadius, int level)
  {
    // draw big circle (initializing)
    float posX = width/2.0 + 50;
    float posY = height/2.0;
       
    Diagram d = new Diagram(dataRecords, maxRadius,1, posX, posY);
    
    ArrayList<DiagramPart> dp1 = d.getDiagram1();
    ArrayList<DiagramPart> dp2 = d.getDiagram2();
    ArrayList<DiagramPart> dp3 = d.getDiagram3();
    
    if (level == 3)
    {
      drawDiagram(3, posX, posY, dp3);
      drawDiagram(2, posX, posY, dp2);
      drawDiagram(1, posX, posY, dp1);
    }
    if (level == 2)
    {
      drawDiagram(2, posX, posY, dp2);
      drawDiagram(1, posX, posY, dp1);
    }
    if (level == 1)
    {
      drawDiagram(1, posX, posY, dp1);
    }     
  }
  
  int getLevel() 
  {
    if (buttonM1.isActivated())
      return 1;
    if (buttonM2.isActivated())
      return 2;
    if (buttonM3.isActivated())
      return 3;
    return 0;
  }
  
  void drawLittleCircles()
  {
    int age = 5;
    int startX = 200; // falls Seitenleiste hinzukommt, hier Breite abziehen
    int startY = 100;
    int drawingWidth = width - startX; 
    int drawingHeight = height - startY;
    int circlesInRow = 7;
    int circlesInColumn = 4;
    int circlesDrawn = 0;
    float maxRadius = Math.min(drawingWidth/circlesInRow,drawingHeight/circlesInColumn) - 10;
    float posX = startX + maxRadius/2;
    float posY = startY + maxRadius/2;
    for (DataRecord dr : dataRecords)
    {
      if (circlesDrawn != 0 && circlesDrawn%circlesInRow == 0)
      {
        posX = startX + maxRadius/2;
        posY += maxRadius + 10;
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
        int level = getLevel();
        
        if (level == 3)
        {
          drawDiagram(3, posX, posY, dp3);
          drawDiagram(2, posX, posY, dp2);
          drawDiagram(1, posX, posY, dp1);
        }
        if (level == 2)
        {
          drawDiagram(2, posX, posY, dp2);
          drawDiagram(1, posX, posY, dp1);
        }
        if (level == 1)
        {
          drawDiagram(1, posX, posY, dp1);
        }  
        
        fill(255);
        textSize(17);
        text(String.valueOf(age),posX-8,posY);
        textSize(15);
        text("Jahre",posX-17,posY+10);
        age++;
        
        posX += maxRadius + 10;
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
            arc(x, y, p.getRadius(), p.getRadius(), p.getAngle1(), p.getAngle2(), PIE);
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
          arc(x, y, p.getRadius(), p.getRadius(), p.getAngle1(), p.getAngle2(), PIE);
        }
      }
    }
    if (level == 1)
    {
      for (DiagramPart p: dp)
      {
        fill(200);
        boolean nearCenter = sqrt(sq(mouseX-x) + sq(mouseY-y)) <= p.radius;
        if (p.mouseInside(x,y) && nearCenter){
          arc(x, y, p.getRadius()+10, p.getRadius()+10, p.getAngle1(), p.getAngle2(), PIE);
        print(p.getRadius());
        print('\t');
        print(sqrt(sq(mouseX-x) - sq(mouseY-y)));
        print('\t');
        print(x);
        print('\t');
        print(mouseX);
        print('\t');
        print(y);
        print('\t');
        println(mouseY);
        }
        else
          arc(x, y, p.getRadius(), p.getRadius(), p.getAngle1(), p.getAngle2(), PIE);
      }
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
    
    fill(255);
    textSize(28);
    text("Zoomlevel",10,50);
    text("Legende",10,180);
  }
  
  void drawHeadlinesView2()
  {
    drawHeadline();

    fill(255);
    textSize(28);
    text("Legende",10,280);
  }
  
}
 
