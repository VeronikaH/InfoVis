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
  
  int getNumberOfSectors()
  {
    return sectors.length;
  }
  
  int getSectorIndex(int dataRecordIndex)
  {
    if(dataRecordIndex == 2)
      return 0;
    else if (dataRecordIndex == 3)
      return 1;
    else if ((dataRecordIndex >= 4) && (dataRecordIndex <= 8 ))
      return 2; 
    else if ((dataRecordIndex >= 9) && (dataRecordIndex <= 12 ))
      return 3; 
    else if ((dataRecordIndex == 13) || (dataRecordIndex == 14 ))
      return 4;
    else if (dataRecordIndex == 15)
      return 5;
    else 
      return -2;
  }
  
 int getSectorIndex(int sectorIndex, int dataRecordIndex)
 {
   if (sectorIndex == 0)
     return 0; 
   else if (sectorIndex == 1)
     return 0;
   else if (sectorIndex == 2) 
     return dataRecordIndex - 4;
   else if (sectorIndex == 3)
     return dataRecordIndex - 9;
   else if (sectorIndex == 4)
     return dataRecordIndex - 13;
   else if (sectorIndex == 5)
     return 0;
   else 
     return -1;
 }
  
  int getNumberOfSchools(int index)
  {
    return sectors[index].getLength();
  }
}
