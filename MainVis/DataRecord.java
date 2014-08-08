public class DataRecord 
{
  int age; 
  float[] all    = new float[16]; 
  float[] male   = new float[16]; 
  float[] female = new float[16]; 
  
  public DataRecord() 
  {
     age = 0; 
  }
  
  public void set(int list, int place, float value)
  {
    if (list == 1) 
      all[place] = value; 
    if (list == 2)
      male[place] = value;
    if (list == 3)
      female[place] = value;
  }
  
  public void setAge(int age) {
    this.age = age;
  }
  
  public float get(int list, int place)
  {
    if (list == 1) 
      return all[place]; 
    else if (list == 2)
      return male[place];
    else if (list == 3)
      return female[place];
    else
      return -1.0f;
  }
  
  public float[] getList(int list)
  {
    if (list == 1) 
      return all; 
    else if (list == 2)
      return male;
    else if (list == 3)
      return female;
    else
      return null;
  }
  
  public int getAge() 
  {
    return this.age;
  }
}
