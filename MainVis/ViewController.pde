import java.lang.*;
import javax.swing.*;
import java.text.DecimalFormat;

public class ViewController
{
  ArrayList<DataRecord> dataRecords;
  ArrayList<DataRecord> selectedDataRecords;
  int viewModus = 1; // 1 -> Übersicht ist groß, Auswahl einzelner Kreise möglich; 2 -> Overviewfenster, Legende, Dropdownmenu, Gesamt; 3 -> wie 2, aber geschlechtergetrennt
  Legend legend = new Legend();
  Button buttonF = new Button("Fertig", width-100, height-80, 80, 50, null, false);
  Button buttonG = new Button("Gesamt", width-100, 15, 80, 50, "gesamt.png", true);
  Button buttonGg = new Button("Geschlechtergetrennt", width-100, 69, 80, 50, "getrennt.png", false);
  Button buttonM1 = new Button("1", 100, 200, 35, 50, null, true);
  Button buttonM2 = new Button("2", 138, 200, 35, 50, null, false);
  Button buttonM3 = new Button("3", 176, 200, 35, 50, null, false);
  Overview overview = new Overview(10, 10, 308, 180);
  boolean firstRun = true;
  ArrayList<Diagram> diagrams;
  boolean[] selection = new boolean[26];


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
        drawHeadlines();
        legend.drawLegend(1);
        buttonF.initiateLeft();
        buttonM1.initiateLeft();
        buttonM2.initiateLeft();
        buttonM3.initiateLeft();
        firstRun = false;
        overview.drawOverview(dataRecords, diagrams, selection);
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
      for (Diagram d : diagrams)
      {
        selection = d.colorBackground();
      }
      selectedDataRecords = new ArrayList<DataRecord>();
      for (int i = 0; i < 26; ++i)
      {
        if (selection[i])
          selectedDataRecords.add(dataRecords.get(i));
      }
      if (selectedDataRecords.size() == 0)
        selectedDataRecords = dataRecords;
    }

    else 
    {
      if (firstRun)
      {
        background(60);
        overview.drawOverview(dataRecords, diagrams, selection);
        drawHeadlines();
        legend.drawLegend(2);
        buttonM1.initiateLeft();
        buttonM2.initiateLeft();
        buttonM3.initiateLeft();
        buttonG.initiateRight();
        buttonGg.initiateRight();
        firstRun = false;
        if (viewModus == 2)
        {
          fill(255); 
          textSize(22);
          if (selectedDataRecords.size() == 26)
            text("5 - 30 Jahre", 750, 700);
          else
          {
            String age = "";
            for(DataRecord dr : selectedDataRecords)
              age += dr.getAge().get(0)+", ";
            age = age.substring(0,age.length()-2);
            text(age + " Jahre", 600, 750);
          }
        }
        else if (viewModus == 3)
        {
          fill(255);
          stroke(255);
          strokeWeight(2);
          line(800, 200, 800, 700);
          textSize(22);
          if (selectedDataRecords.size() == 26)
            text("5 - 30 Jahre", 750, 750);
          else
          {
            String age = "";
            for(DataRecord dr : selectedDataRecords)
              age += dr.getAge().get(0)+", ";
            age = age.substring(0,age.length()-2);
            text(age + " Jahre", 600, 750);
          }
          text("Männer", width/4 +200, 700);
          text("Frauen", 3 * (width/4), 700);
        }
      }
      buttonM1.updateLeft();
      buttonM2.updateLeft();
      buttonM3.updateLeft();
      if (activeButtonChanged) {
        firstRun = true;
        activeButtonChanged = false;
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
        int l = getLevel();
        drawBigCircle(450.0, l);
      }
      else if (viewModus == 3)
      {
        // update two big circles when clicked
        int l = getLevel();
        drawGenderCircle(400.0, 1, l);
        drawGenderCircle(400.0, 2, l);
      }
    }
  }

  void drawGenderCircle(float maxRadius, int gender, int level)
  {
    float posX, posY;
    Diagram d;
    String t2 = "";
    String t1;
    
    if (gender == 1)
    {
      posX = width/4 + 220;
      posY = height/2+50;
      d = new Diagram(selectedDataRecords, maxRadius, 2, posX, posY);
    }
    else
    {
      posX = 3 * (width/4) + 20;
      posY = height/2+50;
      d = new Diagram(selectedDataRecords, maxRadius, 3, posX, posY);
    }
    
    DataRecord dr = d.getData();
    int size = 24;
    noStroke();
    textSize(size);
    t1 = ((Integer)(Math.round(dr.getList(1)[0]))).toString()+" Individuen in dieser Bevölkerungsgruppe";
    int w = (int)textWidth(t1);
    fill(60);
    rect(width/2, 131, w, size);
    fill(250);
    text( t1 , width/2, 150);
    
    t2 += "("+((Integer)(Math.round(dr.getList(2)[0]))).toString()+" männlich, "+ ((Integer)(Math.round(dr.getList(3)[0]))).toString()+" weiblich) ";
    textSize(size*3/4);
    w = (int)textWidth(t2);
    fill(60);
    rect(width/2, 152, w, 50);
    fill(250);
    text( t2 , width/2, 162);
    

    ArrayList<DiagramPart> dp1 = d.getDiagram1();
    ArrayList<DiagramPart> dp2 = d.getDiagram2();
    ArrayList<DiagramPart> dp3 = d.getDiagram3();

    if (level == 3)
    {
      drawInteractiveDiagram(3, posX, posY, dp3, d.getData(), gender+1);
      drawInteractiveDiagram(2, posX, posY, dp2, d.getData(), gender+1);
      drawInteractiveDiagram(1, posX, posY, dp1, d.getData(), gender+1);
    }
    if (level == 2)
    {
      drawInteractiveDiagram(2, posX, posY, dp2, d.getData(), gender+1);
      drawInteractiveDiagram(1, posX, posY, dp1, d.getData(), gender+1);
    }
    if (level == 1)
    {
      drawInteractiveDiagram(1, posX, posY, dp1, d.getData(), gender+1);
    }
  }

  // TODO selectedDataRecords
  void drawBigCircle(float maxRadius, int level)
  {
    // draw big circle (initializing)
    float posX = width/2.0 + 50;
    float posY = height/2.0 + 50;
    
    Diagram d = new Diagram(selectedDataRecords, maxRadius, 1, posX, posY);
      
    
    textSize(24);
    DataRecord dr = d.getData();
    String t1 = ((Integer)(Math.round(dr.getList(1)[0]))).toString()+" Individuen in dieser Bevölkerungsgruppe";
    String t2 = ((Integer)(Math.round(dr.getList(1)[1]))).toString()+" in System erfasst";
    int w = (int) Math.max(textWidth(t1), textWidth(t2));
    fill(60);
    noStroke();
    rect(width/2-200, 131, w, 50);
    fill(250);
    text( t1 , width/2-200, 150);
    //text( t2 , width/2, 175);
    
    ArrayList<DiagramPart> dp1 = d.getDiagram1();
    ArrayList<DiagramPart> dp2 = d.getDiagram2();
    ArrayList<DiagramPart> dp3 = d.getDiagram3();

    if (level == 3)
    {
      drawInteractiveDiagram(3, posX, posY, dp3, dr,1);
      drawInteractiveDiagram(2, posX, posY, dp2, dr,1);
      drawInteractiveDiagram(1, posX, posY, dp1, dr,1);
    }
    if (level == 2)
    {
      drawInteractiveDiagram(2, posX, posY, dp2, dr,1);
      drawInteractiveDiagram(1, posX, posY, dp1, dr,1);
    }
    if (level == 1)
    {
      drawInteractiveDiagram(1, posX, posY, dp1, dr,1);
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
    int startX = 330; // falls Seitenleiste hinzukommt, hier Breite abziehen
    int startY = 100;
    int drawingWidth = width - startX; 
    int drawingHeight = height - startY;
    int circlesInRow = 7;
    int circlesInColumn = 4;
    int circlesDrawn = 0;
    float maxRadius = Math.min(drawingWidth/circlesInRow, drawingHeight/circlesInColumn) - 10;
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
        text(String.valueOf(age), posX-8, posY);
        textSize(15);
        text("Jahre", posX-17, posY+10);
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
      Diagram newDiagram = new Diagram(d, maxRadius, choice, x, y);
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
        arc(x, y, p.getRadius(), p.getRadius(), p.getAngle1(), p.getAngle2(), PIE);
      }
    }
  }


  void drawInteractiveDiagram(int level, float x, float y, ArrayList<DiagramPart> dp, DataRecord info, int dataSet)
  // dataSet: 1->general, 2->male, 3->female 
  {
    int colorIndex1, colorIndex2;
    noStroke();
    if (level == 3)
    {
      boolean first = true;
      int desiredInfo = -1;
      for (DiagramPart p: dp)
      {
        if (first == true)
        {
          fill(60);
          ellipse(x, y, p.radius + 20, p.radius + 20);
          first = false;
        }
        if (p != null)
        {
          colorIndex1 = sc.getSectorIndex(dp.indexOf(p));
          colorIndex2 = sc.getSectorIndex(colorIndex1, dp.indexOf(p));
          if ((colorIndex1 >= 0) && colorIndex2 >= 0)
          {
            fill(sc.getSchoolColor(colorIndex1, colorIndex2));
            boolean nearCenter = sqrt(sq(mouseX-x) + sq(mouseY-y)) < (1.0/2.0)*p.getRadius();
            boolean lowerLevel = sqrt(sq(mouseX-x) + sq(mouseY-y)) < (2.0/6.0)*p.getRadius();
            if (p.mouseInside(x, y) && nearCenter && !lowerLevel && mousePressed)
            {
              desiredInfo = dp.indexOf(p);
              legend.setTags(1,colorIndex1,colorIndex2);
              arc(x, y, p.getRadius()+10, p.getRadius()+10, p.getAngle1(), p.getAngle2(), PIE);
              legend.drawLegend(level);
              noStroke();
            }
            else 
            {
              arc(x, y, p.getRadius(), p.getRadius(), p.getAngle1(), p.getAngle2(), PIE);
              legend.resetTags();
            }
          }
        }
      }
      if (desiredInfo >= 0)
      {
        drawInfo(info, desiredInfo, dataSet,3);
      }
    }

    if (level == 2) 
    {
      int c = 100;
      int desiredInfo = -1;
      for (DiagramPart p: dp)
      {
        if (p != null)
        {
          colorIndex1 = dp.indexOf(p);

          if (colorIndex1 >= 0)
          {
            fill(sc.getSchoolColor(colorIndex1));

            boolean nearCenter = sqrt(sq(mouseX-x) + sq(mouseY-y)) < (1.0/2.0)*p.getRadius();
            boolean lowerLevel = sqrt(sq(mouseX-x) + sq(mouseY-y)) < (1.0/4.0)*p.getRadius();

            if (p.mouseInside(x, y) && nearCenter && !lowerLevel && mousePressed)
            {
              desiredInfo = dp.indexOf(p);
              legend.setDiagramTag(1);
              legend.setSectorTag(colorIndex1);
              arc(x, y, p.getRadius()+10, p.getRadius()+10, p.getAngle1(), p.getAngle2(), PIE);
              legend.drawLegend(level);
              noStroke();
            }
            else
              arc(x, y, p.getRadius(), p.getRadius(), p.getAngle1(), p.getAngle2(), PIE);
              legend.resetTags();
          }
        }
      }
      if (desiredInfo >= 0)
      {
        drawInfo(info, desiredInfo, dataSet,2);
      }
    }
    if (level == 1)
    {
      int desiredInfo = -1;
      for (DiagramPart p: dp)
      {
        fill(200);
        boolean nearCenter = sqrt(sq(mouseX-x) + sq(mouseY-y)) < (1.0/2.0)*p.radius;

        if (p.mouseInside(x, y) && nearCenter && mousePressed)
        {
          desiredInfo = dp.indexOf(p);
          legend.setDiagramTag(1);
          arc(x, y, p.getRadius()+10, p.getRadius()+10, p.getAngle1(), p.getAngle2(), PIE);
          legend.drawLegend(level);
          noStroke();
        }
        else
          arc(x, y, p.getRadius(), p.getRadius(), p.getAngle1(), p.getAngle2(), PIE);
          legend.resetTags();
      }
      
      if (desiredInfo >= 0)
      {
        drawInfo(info, desiredInfo, dataSet,1);
      }
    }
  }
  
  void drawInfo(DataRecord info, int desiredInfo, int dataSet, int level)
  {
    DecimalFormat df = new DecimalFormat("0.00");
    int size = 24;
    textSize(size);
    fill(250);
    int posX, posY;
    if (dataSet == 1)
    {
      posX = 3* (width/4);
      posY = height/2 - 150;
    }
    else if (dataSet == 2)
    {
      posX = width/2 - 260;
      posY = height/2 - 150;
    }
    else
    {
      posX = width/2 + 200;
      posY = height/2 - 150;
    }

   String t = "";
   float w;
    if (level == 1)
    {
      float val = info.getList(dataSet)[1]/info.getList(dataSet)[0];
      t += df.format(val*100.0) + " % in Bildungssystem";
      w = textWidth(t); 
      text(t, posX, posY);
      textSize(size*3/4);
      text("("+ ((Integer)(Math.round(info.getList(1)[0] * val))).toString()+" Individuen)", posX, posY + size);
    }
    else
    {
      float val;
      if (level == 3)
      {
        int index1 = sc.getSectorIndex(desiredInfo);
        int index2 = sc.getSectorIndex(index1, desiredInfo);
        val = info.getList(dataSet)[desiredInfo];
        t += df.format(val) + " % " + sc.getSchoolName(index1,index2);
      }
      else 
      {
        float sum;
        int index = desiredInfo;
        if (desiredInfo == 0)
          sum = info.getList(dataSet)[2];
        else if (desiredInfo == 1)
          sum = info.getList(dataSet)[3];
        else if (desiredInfo == 2)
          sum = info.getList(dataSet)[4] + info.getList(dataSet)[5] + info.getList(dataSet)[6] + info.getList(dataSet)[7] + info.getList(dataSet)[8];
        else if (desiredInfo == 3)
          sum = info.getList(dataSet)[9] + info.getList(dataSet)[10] + info.getList(dataSet)[11] + info.getList(dataSet)[12];
        else if (desiredInfo == 4)
          sum = info.getList(dataSet)[13] + info.getList(dataSet)[14];
        else
          sum = info.getList(dataSet)[15];
          
        val = sum;
        t += df.format(sum) + " % " + sc.getSchoolName(index);
      }
        
      w = textWidth(t); 
      text(t, posX, posY);
      textSize(size*3/4);
      text("("+ ((Integer)(Math.round(info.getList(1)[0] * val/100.0))).toString()+" Individuen)", posX, posY + size);
    }
  }

  void drawHeadline()
  {
    fill(255);
    textSize(32);
    text("Schüler/-innen und Studierende nach Geschlecht,", 350, 50);
    text("Alter und Bildungsbereichen 2010", 450, 85);
  }

  void drawHeadlines()
  {
    drawHeadline();

    fill(255);
    textSize(24);
    text("Zoom", 10, 240);
    text("Legende", 10, 280);
  }
}

