within EMOTH.Interfaces;
expandable connector BatteryBus "EnergyStorage bus"
  extends VehicleInterfaces.Interfaces.BatteryBus;
  Modelica.Units.SI.Voltage vDC "DC voltage";
  Modelica.Units.SI.Current iDC "DC current";
  Modelica.Units.SI.Power PDC "DC power";
  Modelica.Units.SI.Power Losses "Losses";
  Modelica.Units.SI.Energy EDC "Energy consumption";
  Real SoC "State of charge";
  annotation (Documentation(info="<html>
<p>
Bus to exchange signals between the battery resp. <a href=\"modelica://EMOTH.EnergyStorages\">electric energy storage</a> and the common control bus. 
</p>
</html>"));
end BatteryBus;
