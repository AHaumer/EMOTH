within EMOTH.Interfaces;
expandable connector ElectricMotorBus "ElectricDrive bus"
  extends VehicleInterfaces.Interfaces.BrakesBus;
  Real throttle "Normalized throttle signal";
  Modelica.Units.SI.AngularVelocity w(displayUnit="rpm") "Motor speed";
  Modelica.Units.SI.Torque tau "Motor torque";
  Modelica.Units.SI.Power Pm "Mechanical motor power";
  Modelica.Units.SI.Voltage vDC "DC voltage";
  Modelica.Units.SI.Current iDC "DC current";
  Modelica.Units.SI.Power Pel "Electrical DC power";
  Modelica.Units.SI.Power Losses "Losses";
  annotation (Documentation(info="<html>
<p>
Bus to exchange signals between the electric motor resp. <a href=\"modelica://EMOTH.ElectricDrives\">electric drive</a> and the common control bus. 
</p>
</html>"));
end ElectricMotorBus;
