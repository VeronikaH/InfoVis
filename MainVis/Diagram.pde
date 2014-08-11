public class Diagram
{
  ArrayList<DiagramPart> diagram1;
  ArrayList<DiagramPart> diagram2;
  ArrayList<DiagramPart> diagram3; 
  float centerX, centerY;
  float maximum_radius;
  
  // important choice 1,2 or 3 !!
  public Diagram(ArrayList<DataRecord> dataSet, float max_radius, int choice, float x, float y) 
  {
    diagram1 = new ArrayList<DiagramPart>(); 
    diagram2 = new ArrayList<DiagramPart>(); 
    diagram3 = new ArrayList<DiagramPart>(); 
    this.centerX = x;
    this.centerY = y;
    this.maximum_radius = max_radius;
    float radius1 = (1.0/3.0) * this.maximum_radius;
    float radius2 = (2.0/3.0) * this.maximum_radius;
    float epsilon = 0.0000001;
    if ((choice <= 1) && (choice >= 3))
    {
      for (DataRecord d: dataSet) 
      {
        float[] list = d.getList(choice); 
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
            diagram3.add(new DiagramPart(max_radius,start,stop)); 
            start = stop;
          }
          else
            diagram3.add(null);
        }
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
