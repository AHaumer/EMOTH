within EMOTH.Interfaces;
expandable connector BatteryBus "EnergyStorage bus"
  extends VehicleInterfaces.Interfaces.BatteryBus;
  Modelica.SIunits.Voltage vDC "DC voltage";
  Modelica.SIunits.Current iDC "DC current";
  Modelica.SIunits.Power PDC "DC power";
  Modelica.SIunits.Power Losses "Losses";
  Modelica.SIunits.Energy EDC "Energy consumption";
  Real SoC "State of charge";
  annotation (Documentation(info="<html>
<p>
Bus to exchange signals between the battery resp. <a href=\"modelica://EMOTH.EnergyStorages\">electric energy storage</a> and the common control bus. 
</p>
</html>"));
end BatteryBus;
