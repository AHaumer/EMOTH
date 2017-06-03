within EMOTH.Interfaces;
expandable connector ElectricMotorBus "ElectricDrive bus"
  extends VehicleInterfaces.Interfaces.BrakesBus;
  Real throttle "Normalized throttle signal";
  Modelica.SIunits.AngularVelocity w(displayUnit="rpm") "Motor speed";
  Modelica.SIunits.Torque tau "Motor torque";
  Modelica.SIunits.Power Pm "Mechanical motor power";
  Modelica.SIunits.Voltage vDC "DC voltage";
  Modelica.SIunits.Current iDC "DC current";
  Modelica.SIunits.Power Pel "Electrical DC power";
  Modelica.SIunits.Power Losses "Losses";
  annotation (Documentation(info="<html>
<p>
Bus to exchange signals between the electric motor resp. <a href=\"modelica://EMOTH.ElectricDrives\">electric drive</a> and the common control bus. 
</p>
</html>"));
end ElectricMotorBus;
