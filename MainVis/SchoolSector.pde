import java.util.Map;
import java.awt.*;

public class SchoolSector
{
  String sectorName;
  color sectorColor;
  String[] schoolNames;
  color[] schoolColors;
  
  SchoolSector(String sectorName, color sectorColor, String[] schoolNames, color[] schoolColors)
  {
    this.sectorName = sectorName;
    this.sectorColor = sectorColor;
    this.schoolNames = schoolNames;
    this.schoolColors = schoolColors;
  }
  
  String getSectorName()
  {
    return sectorName;
  }
  
  color getSectorColor()
  {
    return sectorColor;
  }
  
  String getSchoolName(int index)
  {
    return schoolNames[index];
  }
  
  color getSchoolColor(int index)
  {
    return schoolColors[index];
  }
  
  int getLength()
  {
    return schoolNames.length;
  }
}
