within EMOTH.Interfaces;
expandable connector DriverInterface "Bus interface to driver"
  extends VehicleInterfaces.Interfaces.DriverInterface;
  Modelica.Units.SI.Position s(displayUnit="km") "Vehicle position";
  Modelica.Units.SI.Velocity v(displayUnit="km/h") "Vehicle velocity";
  Modelica.Units.SI.Acceleration a "Vehicle acceleration";
  Modelica.Units.SI.Velocity vReference(displayUnit="km/h")
    "Reference velocity";
  Modelica.Units.SI.Time tPreview "Preview time";
  Modelica.Units.SI.Velocity vPreview(displayUnit="km/h") "Preview velocity";
  Boolean forward "Direction of movement (true=forward / false=backward)";
  Real fn_brake "Normalized total braking force";
  Real throttle "Normalized throttle signal";
  Real SoC "State of charge";
  Modelica.Units.SI.Voltage vDC "DC voltage";
  Modelica.Units.SI.Current iDC "DC current";
  Modelica.Units.SI.Power pDC "DC power";
  EMOTH.Drivers.Components.LinearEnergyConsumption Eav "Average energy consumption per distance";
  annotation (Documentation(info="<html>
<p>
Bus to exchange signals between <a href=\"modelica://EMOTH.Drivers.DrivingCycle\">driving cycle</a>, <a href=\"modelica://EMOTH.Drivers.Driver\">driver</a> and 
<a href=\"modelica://EMOTH.Drivers.DriverEnvironment\">driver environment</a>. 
The <a href=\"modelica://EMOTH.Drivers.DriverEnvironment\">driver environment model</a> exhanges signals between this driver interface and the common 
<a href=\"modelica://EMOTH.Interfaces.ControlBus\">control bus</a>.
</p>
</html>"));
end DriverInterface;
