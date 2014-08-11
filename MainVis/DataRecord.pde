public class DataRecord 
{
  IntList age;
  float[] all; 
  float[] male; 
  float[] female; 
  
  public DataRecord() 
  {
    age = new IntList();
    all = new float[16];
    male = new float[16];
    female = new float[16];
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
  
  public void addVal(int list, int place, float value)
  {
    if (list == 1) 
      all[place] += value; 
    if (list == 2)
      male[place] += value;
    if (list == 3)
      female[place] += value;
  }
  
  public void addAge(int age) {
    this.age.append(age);
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
  
  public IntList getAge() 
  {
    return this.age;
  }
}
