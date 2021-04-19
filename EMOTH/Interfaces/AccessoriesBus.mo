within EMOTH.Interfaces;
expandable connector AccessoriesBus "Accessories bus"
  extends VehicleInterfaces.Interfaces.AccessoriesBus;
  Modelica.Units.SI.Voltage vDC "DC voltage";
  Modelica.Units.SI.Current iDC "DC current";
  Modelica.Units.SI.Power PDC "DC power";
  Modelica.Units.SI.Energy EDC "Energy consumption";
  annotation (Documentation(info="<html>
<p>
Bus to exchange signals between <a href=\"modelica://EMOTH.Accessories\">accessories</a> and the common control bus. 
</p>
</html>"));
end AccessoriesBus;
