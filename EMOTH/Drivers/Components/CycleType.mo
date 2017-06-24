within EMOTH.Drivers.Components;
type CycleType = enumeration(
    Table "User defined driving cycle (table)",
    UDC "Urban driving cycle",
    EUDC "Extra-urban driving cycle",
    NEDC "New European driving cycle",
    WLTC "Worldwide Harmonized Light-Duty Vehicles Test Procedure - Class 3",
    FTP75 "EPA Federal Test Procedure - 75")
  "Enumeration defining the type of the driving cycle";
