within EMOTH.Interfaces;
expandable connector RexBus "Range extender bus"
  extends VehicleInterfaces.Interfaces.AccessoriesBus;
  Modelica.SIunits.Voltage vDC "DC voltage";
  Modelica.SIunits.Current iDC "DC current";
  Modelica.SIunits.Power PDC "DC power";
  Modelica.SIunits.Energy EDC "Energy consumption";
  annotation (Documentation(info="<html>
<p>
Bus to exchange signals between <a href=\"modelica://EMOTH.Accessories\">accessories</a> and the common control bus. 
</p>
</html>"));
end RexBus;
