// Fullscreen: Sketch -> Present oder STRG + UMSCHALT + R
import java.awt.*;


String[] lines;
ArrayList<DataRecord> dataRecords = new ArrayList<DataRecord>();
ViewController viewController;
String activeButtonZoom = "1"; // wichtig für Zoombuttoninteraktion
String activeButtonSex = "Gesamt";
boolean activeButtonChanged = false;

SchoolSector first = new SchoolSector(
  "Vorschulbereich", 
  color(238,180,34), 
  new String[] {"Vorklasse"}, 
  new color[] {color(255,215,0)}
);
SchoolSector second = new SchoolSector(
  "Primarbereich",
  color(205,055,0), 
  new String[] {"Grundschule"}, 
  new color[] {color(255,127,0)}
);
SchoolSector third = new SchoolSector(
  "Sekundarbereich I", 
  color(255,0,0), 
  new String[] {"Hauptschule", "Freie Waldorfschule", "Integrierte Gesamtschule", "Realschule", "Gymnasium"}, 
  new color[] {color(139,0,0), color(255,20,147), color(255,181,197), color(255,48,48), color(139,10,80)}
);
SchoolSector fourth = new SchoolSector(
  "Sekundarbereich II",
  color(0,139,0), 
  new String[] {"Gymnasium", "Berufsschule", "Berufsfachschule", "Fachgymnasium"}, 
  new color[] {color(205,198,115), color(102,205,0), color(0,255,127), color(124,205,124)}
);
SchoolSector fifth = new SchoolSector(
  "Tertiärbereich",
  color(0,0,139), 
  new String[] {"Fachschule", "Hochschule"}, 
  new color[] {color(100,149,237), color(142,229,238)}
);
SchoolSector sixth = new SchoolSector(
  "Sonderbereich",
  color(205,133,63), 
  new String[] {"Förderschule"}, 
  new color[] {color(255,211,155)}
);
SchoolController sc = new SchoolController(new SchoolSector[] {first, second, third, fourth, fifth, sixth});
/**
* Benutzung:
* sc.getSchoolName(int index) -> Name des übergeordneten Bereiches (z.B.: 0 -> "Vorschulbereich", 1 -> "Primarbereich"...)
* sc.getSchoolName(int index1, int index2) -> Name des spezifischen Schultyps (z.B.: index1 = 2, index2 = 3 -> "Realschule")
* analog: sc.getSchoolColor(...)
**/


void setup() 
{
  size(displayWidth,displayHeight);
  background(60);
  lines = loadStrings("data.txt");
  readDataFile();
  viewController = new ViewController(dataRecords);
}

void draw() 
{
  viewController.drawInterface();
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
        dr.addAge(age);
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
