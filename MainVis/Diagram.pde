public class Diagram
{
  ArrayList<DiagramPart> diagram1;
  ArrayList<DiagramPart> diagram2;
  ArrayList<DiagramPart> diagram3; 
  float centerX, centerY;
  float maximumRadius;
  
  
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
      
    Diagram d = new Diagram(combinedData, maxRadius, choice, x, y);
    this.diagram1 = d.getDiagram1();
    this.diagram2 = d.getDiagram2();
    this.diagram3 = d.getDiagram3();   
  }
  
  public Diagram(DataRecord data, float maxRadius, int choice, float x, float y)
  // choice {1,2,3} -> general, male, female 
  {
    diagram1 = new ArrayList<DiagramPart>(); 
    diagram2 = new ArrayList<DiagramPart>(); 
    diagram3 = new ArrayList<DiagramPart>(); 
    
    this.centerX = x;
    this.centerY = y;
    this.maximumRadius = maxRadius;
    
    float radius1 = (1.0/3.0) * this.maximumRadius;
    float radius2 = (2.0/3.0) * this.maximumRadius;
    float epsilon = 0.0000001;
    
    if ((choice <= 1) && (choice >= 3))
    {
      float[] list = data.getList(choice); 
      
      float start = 0.0;
      float stop = 2 * PI;
      float factor;
      
      // first level
      factor = list[1] / list[0]; 
      stop *= factor;
      diagram1.add(new DiagramPart(radius1,start, stop));
      
      // second level
      start = 0.0;
      float[] schoolTypes = new float [6];
      schoolTypes[0] = list[2] * list[1]; 
      schoolTypes[1] = list[3] * list[1]; 
      schoolTypes[2] = (list[4] + list[5] + list[6] + list[7] + list[8]) * list[1]; 
      schoolTypes[3] = (list[9] + list[10] + list[11] + list[12]) * list[1];
      schoolTypes[4] = (list[13] + list[14]) * list[1]; 
      schoolTypes[5] = list[15] * list[1]; 
      for (float s: schoolTypes)
      {
        if (s > epsilon)
        {
          factor = s / list[0];
          stop = start + factor*2*PI;
          diagram2.add(new DiagramPart(radius2,start,stop)); 
          start = stop;
        }
        else
          diagram2.add(null);
      }
     
     // third level 
     start = 0.0;
      for (float f: list)
      {
        if (f > epsilon)
        {
          factor = f/list[0];
          stop = start + factor*2*PI;
          diagram3.add(new DiagramPart(maxRadius,start,stop)); 
          start = stop;
        }
        else
          diagram3.add(null);
      }
    }
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
  
}

public DataRecord prepare(ArrayList<DataRecord> dataRecords)
{
  DataRecord combinedData = new DataRecord();
  int all, male, female; 
  int allSys, maleSys, femaleSys;
  for (DataRecord d: dataRecords)
  {
    int age = d.getAge().get(0);
    if (!(d.getAge().hasValue(age)))
    {
      combinedData.addAge(age);
    
      for (int i = 0; i < 2; i++)
      {
        combinedData.addVal(1,i, d.get(1,i));
        combinedData.addVal(2,i, d.get(2,i));
        combinedData.addVal(3,i, d.get(3,i));
      }
      
      for (int i = 2; i < 16; i++)
      {
        combinedData.addVal(1,i, d.get(1,i) * d.get(1,1));
        combinedData.addVal(2,i, d.get(2,i) * d.get(2,1));
        combinedData.addVal(3,i, d.get(3,i) * d.get(3,1));
      }
    }
    for (int i = 2; i < 16; i++)
    {
      combinedData.addVal(1,i, d.get(1,i) / d.get(1,0));
      combinedData.addVal(2,i, d.get(2,i) / d.get(2,0));
      combinedData.addVal(3,i, d.get(3,i) / d.get(3,0));
    }
  }
  return combinedData;
}
