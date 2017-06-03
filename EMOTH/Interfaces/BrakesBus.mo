within EMOTH.Interfaces;
expandable connector BrakesBus "Brake bus"
  extends VehicleInterfaces.Interfaces.BrakesBus;
  Real fn_brake "Normalized total braking force";
  Modelica.SIunits.AngularVelocity w_1(displayUnit="rpm") "Wheel speed 1";
  Modelica.SIunits.AngularVelocity w_2(displayUnit="rpm") "Wheel speed 2";
  Modelica.SIunits.AngularVelocity w_3(displayUnit="rpm") "Wheel speed 3";
  Modelica.SIunits.AngularVelocity w_4(displayUnit="rpm") "Wheel speed 4";
  Modelica.SIunits.AngularAcceleration a_1 "Wheel acceleration 1";
  Modelica.SIunits.AngularAcceleration a_2 "Wheel acceleration 2";
  Modelica.SIunits.AngularAcceleration a_3 "Wheel acceleration 3";
  Modelica.SIunits.AngularAcceleration a_4 "Wheel acceleration 4";
  Modelica.SIunits.Torque tau_1 "Braking torque wheel 1";
  Modelica.SIunits.Torque tau_2 "Braking torque wheel 2";
  Modelica.SIunits.Torque tau_3 "Braking torque wheel 3";
  Modelica.SIunits.Torque tau_4 "Braking torque wheel 4";
  Modelica.SIunits.Power P "Total braking power";
  Modelica.SIunits.Power Losses "Losses";
  annotation (Documentation(info="<html>
<p>
Bus to exchange signals between the <a href=\"modelica://EMOTH.Brakes\">brake system</a> and the common control bus. 
</p>
</html>"));
end BrakesBus;
