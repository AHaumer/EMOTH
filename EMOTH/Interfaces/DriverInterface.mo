within EMOTH.Interfaces;
expandable connector DriverInterface "Bus interface to driver"
  extends VehicleInterfaces.Interfaces.DriverInterface;
  Modelica.SIunits.Position s(displayUnit="km") "Vehicle position";
  Modelica.SIunits.Velocity v(displayUnit="km/h") "Vehicle velocity";
  Modelica.SIunits.Acceleration a "Vehicle acceleration";
  Modelica.SIunits.Velocity vReference(displayUnit="km/h") "Reference velocity";
  Modelica.SIunits.Time tPreview "Preview time";
  Modelica.SIunits.Velocity vPreview(displayUnit="km/h") "Preview velocity";
  Boolean forward "Direction of movement (true=forward / false=backward)";
  Real fn_brake "Normalized total braking force";
  Real throttle "Normalized throttle signal";
  Real SoC "State of charge";
  Modelica.SIunits.Voltage vDC "DC voltage";
  Modelica.SIunits.Current iDC "DC current";
  Modelica.SIunits.Power pDC "DC power";
  annotation (Documentation(info="<html>
<p>
Bus to exchange signals between <a href=\"modelica://EMOTH.Drivers.DrivingCycle\">driving cycle</a>, <a href=\"modelica://EMOTH.Drivers.Driver\">driver</a> and 
<a href=\"modelica://EMOTH.Drivers.DriverEnvironment\">driver environment</a>. 
The <a href=\"modelica://EMOTH.Drivers.DriverEnvironment\">driver environment model</a> exhanges signals between this driver interface and the common 
<a href=\"modelica://EMOTH.Interfaces.ControlBus\">control bus</a>.
</p>
</html>"));
end DriverInterface;
