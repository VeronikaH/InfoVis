<<<<<<< HEAD
void setup() 
{
  size(500, 500);
  background(200, 100, 0);
} 
=======
String[] lines;
ArrayList<DataRecord> dataRecords = new ArrayList<DataRecord>();

void setup() 
{
  lines = loadStrings("data.txt");
  readDataFile();
}

>>>>>>> feb1abcbb98cb7934e179d3d3edfa7d80d03109b
void draw() 
{
  
}

void readDataFile()
{
  DataRecord dr = null;

  int startLine = 9;
  int stopLine = 87;
  int modus = -1;
  float part = -1;
  int counter = 0;
  
  for (int i = startLine; i < stopLine; ++i)
  {
    String[] stringParts = lines[i].split(";");
    for (int k = 0; k < stringParts.length; ++k)
    {
      if (stringParts[k].contains("Jahre"))
      { // neues Objekt anlegen
        String[] parts = stringParts[k].split(" ");
        int age = Integer.parseInt(parts[0]);
        if (dr != null)
          dataRecords.add(dr);
        dr = new DataRecord();
        dr.setAge(age);
        counter = 0;
      }
      else if (stringParts[k].contains("insgesamt")) 
      {
        modus = 1;
        counter = 0;
      }
      else if (stringParts[k].contains("nnlich")) 
      {
        modus = 2;
        counter = 0;
      }
      else if (stringParts[k].contains("weiblich")) 
      {
        modus = 3;
        counter = 0;
      }
      else if (stringParts[k].equals("-"))
        counter++; // nichts tun -> array bereits mit Null initialisiert
      else if (stringParts[k].equals(""))
        ; // nichts tun -> Anfang einer Zeile ohne Wert (männlich/weiblich)
      else
      { // Objekt befüllen je nachdem, ob all/male/female gerade true
        stringParts[k] = stringParts[k].replace(",",".");
        part = Float.parseFloat(stringParts[k]);
        dr.set(modus,counter,part);
        counter++;
      }
    }
  }
  if (dr != null)
    dataRecords.add(dr);
}
