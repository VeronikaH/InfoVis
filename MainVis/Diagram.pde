public class Diagram
{
  ArrayList<DiagramPart> diagram; 
  
  // important choice 1,2 or 3 !!
  public Diagram(ArrayList<DataRecord> dataSet, float radius, int choice, int level, float x, float y) 
  {
    diagram = new ArrayList<DiagramPart>(); 
    float epsilon = 0.0000001;
    if (((choice <= 1) && (choice >= 3)) && ((level <= 1) && (level >= 3)))
    {
      for (DataRecord d: dataSet) 
      {
        float[] list = d.getList(choice); 
        float start = 0.0;
        float stop = 2 * PI;
        float factor;
        if (level == 1)
        {
          factor = list[1] / list[0]; 
          stop *= factor;
          diagram.add(new DiagramPart(x,y,radius,start, stop));
        }
        if (level == 2)
        {
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
              diagram.add(new DiagramPart(x,y,radius,start,stop)); 
              start = stop;
            }
            else
              diagram.add(null);
          }
        }
        if (level == 3)
        {
          for (float f: list)
          {
            if (f > epsilon)
            {
              factor = f/list[0];
              stop = start + factor*2*PI;
              diagram.add(new DiagramPart(x,y,radius,start,stop)); 
              start = stop;
            }
            else
              diagram.add(null);
          }
        }
      }
    }
  }
  
}
