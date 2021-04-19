within EMOTH.Chassis.Components;
model RollingResistance
  "Constant force changing sign with speed, multiplied by cos(atan(inclination))"
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  import Modelica.Constants.g_n;
  parameter Modelica.Units.SI.Mass m "Total mass including passengers";
  parameter Modelica.Units.SI.Velocity v0(final min=Modelica.Constants.eps,
      start=0.1) "Regularization below v0";
  Modelica.Units.SI.Velocity v
    "Velocity of flange with respect to support (= der(s))";
  Modelica.Blocks.Interfaces.RealInput inclination "Inclination"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput rollingResistance "Inclination"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
equation
  v = der(s);
  f = rollingResistance*m*g_n*(if abs(v)>=v0 then sign(v) else (v/v0))*cos(atan(inclination));
  //(2/(1 + exp(-v/(0.01*v0))) - 1)
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
          Line(
            points={{-100,0},{100,0}},
            color={0,0,127}),
        Line(points={{-80,-40},{-6,-40},{-4,-38},{4,38},{6,40},{80,40}},
            color={0,0,0})}), Documentation(info="<html>
<p>Model of constant force which changes sign with direction of movement, 
mulitplied by the cosine of inclination angle.</p>
<p>Please note:<br>
Positive force acceleractes in both directions of movement.<br>
Negative force brakes in both directions of movement.</p>
<p>Around zero speed regularization avoids numerical problems.</p>
</html>"));
end RollingResistance;
