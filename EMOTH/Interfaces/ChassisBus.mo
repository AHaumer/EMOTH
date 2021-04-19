within EMOTH.Interfaces;
expandable connector ChassisBus "Chassis bus"
  extends VehicleInterfaces.Interfaces.ChassisBus;
  Real inclination "Inclination of road";
  Real cr "Rolling resistance coefficient";
  Modelica.Units.SI.Velocity vWind(displayUnit="km/h") "Wind speed";
  Modelica.Units.SI.Position s "Vehicle position";
  Modelica.Units.SI.Position x "Horizontal x-position of vehicle";
  Modelica.Units.SI.Position z "Vertical z-position of vehicle";
  Modelica.Units.SI.Velocity v(displayUnit="km/h") "Vehicle velocity";
  Modelica.Units.SI.Acceleration a "Vehicle acceleration";
  Modelica.Units.SI.Force f "Resistance forces";
  Modelica.Units.SI.Power P "Resistance power";
  Modelica.Units.SI.Energy E "Resistance Energy";
  annotation (Documentation(info="<html>
<p>
Bus to exchange signals between the <a href=\"modelica://EMOTH.Chassis\">chassis</a> and the common control bus. 
</p>
</html>"));
end ChassisBus;
