within EMOTH.Interfaces;
expandable connector ChassisBus "Chassis bus"
  extends VehicleInterfaces.Interfaces.ChassisBus;
  Real inclination "Inclination of road";
  Real cr "Rolling resistance coefficient";
  Modelica.SIunits.Velocity vWind(displayUnit="km/h") "Wind speed";
  Modelica.SIunits.Position s "Vehicle position";
  Modelica.SIunits.Position x "Horizontal x-position of vehicle";
  Modelica.SIunits.Position z "Vertical z-position of vehicle";
  Modelica.SIunits.Velocity v(displayUnit="km/h") "Vehicle velocity";
  Modelica.SIunits.Acceleration a "Vehicle acceleration";
  Modelica.SIunits.Force f "Resistance forces";
  Modelica.SIunits.Power P "Resistance power";
  Modelica.SIunits.Energy E "Resistance Energy";
  annotation (Documentation(info="<html>
<p>
Bus to exchange signals between the <a href=\"modelica://EMOTH.Chassis\">chassis</a> and the common control bus. 
</p>
</html>"));
end ChassisBus;
