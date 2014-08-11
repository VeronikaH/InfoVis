public class SchoolController
{
  SchoolSector[] sectors;
  
  SchoolController(SchoolSector[] sectors)
  {
    this.sectors = sectors;
  }
  
  String getSchoolName(int index)
  {
    return sectors[index].getSectorName();
  }
  
  String getSchoolName(int index1, int index2)
  {
    return sectors[index1].getSchoolName(index2);
  }
  
  color getSchoolColor(int index)
  {
    return sectors[index].getSectorColor();
  }
  
  color getSchoolColor(int index1, int index2)
  {
    return sectors[index1].getSchoolColor(index2);
  }
}
