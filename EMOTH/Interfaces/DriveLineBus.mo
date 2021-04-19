within EMOTH.Interfaces;
expandable connector DriveLineBus "Rear axle driveline bus"
  extends VehicleInterfaces.Interfaces.DrivelineBus;
  Modelica.Units.SI.AngularVelocity w_0(displayUnit="rpm") "Central speed";
  Modelica.Units.SI.AngularAcceleration a_0 "Central acceleration";
  Modelica.Units.SI.Torque tau_0 "Central driving torque";
  Modelica.Units.SI.Power P_0 "Central driving power";
  Modelica.Units.SI.AngularVelocity w_3(displayUnit="rpm") "Half axle speed 3";
  Modelica.Units.SI.AngularVelocity w_4(displayUnit="rpm") "Half axle speed 4";
  Modelica.Units.SI.AngularAcceleration a_3 "Half axle acceleration 3";
  Modelica.Units.SI.AngularAcceleration a_4 "Half axle acceleration 4";
  Modelica.Units.SI.Torque tau_3 "Half axle driving torque 3";
  Modelica.Units.SI.Torque tau_4 "Half axle driving torque 4";
  Modelica.Units.SI.Power P_3 "Half axle driving power 3";
  Modelica.Units.SI.Power P_4 "Half axle driving power 4";
  Modelica.Units.SI.Power Losses "Losses";
  annotation (Documentation(info="<html>
<p>
Bus to exchange signals between the <a href=\"modelica://EMOTH.DriveLines\">drive line</a> and the common control bus. 
</p>
</html>"));
end DriveLineBus;
