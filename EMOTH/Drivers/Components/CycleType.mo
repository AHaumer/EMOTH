within EMOTH.Drivers.Components;
type CycleType = enumeration(
    Table "User defined driving cycle (table)",
    UDC "Urban driving cycle",
    EUDC "Extra-urban driving cycle",
    NEDC "New European driving cycle",
    WLTC "Worldwide Harmonized Light-Duty Vehicles Test Procedure - Class 3",
    FTP75 "EPA Federal Test Procedure - 75",
    CADCU "Common Artemis Driving Cycle - Urban",
    CADCR "Common Artemis Driving Cycle - Rural Road",
    CADCM130 "Common Artemis Driving Cycle - Motor Highway 130 km/h",
    CADCM150 "Common Artemis Driving Cycle - Motor Highway 150 km/h",
    CADC130 "Common Artemis Driving Cycle - Complete 130 km/h",
    CADC150 "Common Artemis Driving Cycle - Complete 150 km/h")
  "Enumeration defining the type of the driving cycle";
