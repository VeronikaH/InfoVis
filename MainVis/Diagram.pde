public class Diagram
{
  ArrayList<DiagramPart> diagram1;
  ArrayList<DiagramPart> diagram2;
  ArrayList<DiagramPart> diagram3; 
  float centerX, centerY;
  float maximumRadius;
  boolean[] selected = new boolean[26];
  DataRecord data;
  
  
  public Diagram(ArrayList<DataRecord> dataSet, float maxRadius, int choice, float x, float y)
  // choice {1,2,3} -> general, male, female 
  {
    this.centerX = x;
    this.centerY = y;
    this.maximumRadius = maxRadius;
    
    DataRecord combinedData;
    if (dataSet.size() > 1)
      combinedData = prepare(dataSet);
    else
      combinedData = dataSet.get(0);
      
    data = combinedData;
    Diagram d = new Diagram(combinedData, maxRadius, choice, x, y);
    this.diagram1 = d.getDiagram1();
    this.diagram2 = d.getDiagram2();
    this.diagram3 = d.getDiagram3();   
  }
  
  public Diagram(DataRecord inputData, float maxRadius, int choice, float x, float y)
  // choice {1,2,3} -> general, male, female 
  {
    diagram1 = new ArrayList<DiagramPart>(); 
    diagram2 = new ArrayList<DiagramPart>(); 
    diagram3 = new ArrayList<DiagramPart>(); 
    
    data = inputData;
    
    this.centerX = x;
    this.centerY = y;
    this.maximumRadius = maxRadius;
    
    float radius1 = (1.0/3.0) * this.maximumRadius;
    float radius2 = (2.0/3.0) * this.maximumRadius;
    float epsilon = 0.0000001;
    
    if ((choice >= 1) && (choice <= 3))
    {
      float[] list = data.getList(choice); 
      
      float start = 0.0;
      float stop = 2 * PI;
      float factor;
      
      // first level
      factor = list[1] / list[0]; 
      stop *= factor;
      if (stop > 2 * PI)
        stop = 2 * PI;
      diagram1.add(new DiagramPart(radius1,start, stop));
   
      // second level
      start = 0.0;
      float[] schoolTypes = new float [6];
      schoolTypes[0] = list[2]; 
      schoolTypes[1] = list[3]; 
      schoolTypes[2] = list[4] + list[5] + list[6] + list[7] + list[8]; 
      schoolTypes[3] = list[9] + list[10] + list[11] + list[12];
      schoolTypes[4] = list[13] + list[14]; 
      schoolTypes[5] = list[15]; 
      for (float s: schoolTypes)
      {
        if ( s > epsilon)
        {
          if (s > 100 + epsilon)
            factor = 100.0;
          else 
            factor = s;
          stop = start + (factor/100.0)*2*PI;
          diagram2.add(new DiagramPart(radius2,start,stop));
          start = stop;
          if (stop > 2 * PI)
            stop = 2 * PI;
        }
        else
          diagram2.add(new DiagramPart(0,0,0));
      }
     
     // third level 
     start = 0.0;
      for (float f: list)
      {
        if (f > epsilon)
        {
          factor = f/list[0];
          if (f > 100 + epsilon)
            factor = 100.0;
          else 
            factor = f;
            stop = start + (factor/100.0)*2*PI;
          diagram3.add(new DiagramPart(maxRadius,start,stop)); 
          start = stop;
          if (stop > 2 * PI)
            stop = 2 * PI;
        }
        else
          diagram3.add(new DiagramPart(0,0,0));
      }
    }
  }
  
  public boolean[] colorBackground()
  {
    float x = centerX+100-maximumRadius-23;
    float y = centerY+100-maximumRadius-23;
    float rWidth = maximumRadius + 2;
    float rHeight = maximumRadius + 2;
    int circlesInRow = 7;
    int circlesDrawn = 0;
    boolean inside = false;
    int counter = 0;
    boolean[] deselect = new boolean[26];
    
    for (int i = 0; i < 26; ++i)
    {
      fill(0,0,0,0);
      strokeWeight(1);
      
      if (selected[i])
        stroke(255);
      else
      {
        stroke(0);
      }
      if (mouseX < x + rWidth && mouseX > x && mouseY < y + rHeight && mouseY > y)
      {
        stroke(255);
        inside = true;
        if (mousePressed && mouseButton == LEFT)
          selected[i] = true;
        else if (mousePressed && mouseButton == RIGHT)
          selected[i] = false;
      }
      
       rect(x,y, rWidth, rHeight);
       x += maximumRadius+10;
       circlesDrawn++;
       if (circlesDrawn%7 == 0 && circlesDrawn != 0)
       {
         y += maximumRadius+10;
         x = centerX+100-maximumRadius-23;
       }
    }
    //if(inside)
      //cursor(HAND);
    return selected;
  }
  
  public float getCenterX() 
  {
    return this.centerX;
  }
  
  public float getCenterY() 
  {
    return this.centerY;
  }
  
  public void setCenterX(float x) 
  {
    this.centerX = x;
  }
  
  public void setCenterY(float y) 
  {
    this.centerY = y;
  }
  
  public ArrayList<DiagramPart> getDiagram1() 
  {
    return this.diagram1;
  }
  
  public ArrayList<DiagramPart> getDiagram2() 
  {
    return this.diagram2;
  }
  
  public ArrayList<DiagramPart> getDiagram3() 
  {
    return this.diagram3;
  }
  
  public DataRecord getData()
  {
    return this.data;
  }
  
}

public DataRecord prepare(ArrayList<DataRecord> dataRecords)
{
  DataRecord combinedData = new DataRecord();
  
  for (DataRecord d: dataRecords)
  {
    combinedData.addVal(1,0, d.get(1,0));
    combinedData.addVal(2,0, d.get(2,0));
    combinedData.addVal(3,0, d.get(3,0));
    combinedData.addVal(1,1, d.get(1,1));
    combinedData.addVal(2,1, d.get(2,1));
    combinedData.addVal(3,1, d.get(3,1));
    
    for (int i = 2; i < 16; i++)
    {
      combinedData.addVal(1,i, (float) (d.get(1,0) * d.get(1,i)));
      combinedData.addVal(2,i, (float) (d.get(2,0) * d.get(2,i)));
      combinedData.addVal(3,i, (float) (d.get(3,0) * d.get(3,i)));
    }
  }
  
  float a1, a2, b1, b2, c1, c2;
  a1 = combinedData.get(1,0);
  b1 = combinedData.get(2,0);
  c1 = combinedData.get(3,0);
  for (int i = 2; i < 16; i++)
  {
    a2 = combinedData.get(1,i);
    b2 = combinedData.get(2,i);
    c2 = combinedData.get(3,i);
    
    combinedData.set(1,i, (float) (a2 / a1));
    combinedData.set(2,i, (float) (b2 / b1));
    combinedData.set(3,i, (float) (c2 / c1));
  }
  
  return combinedData;
}
