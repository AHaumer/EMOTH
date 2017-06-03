within EMOTH.Chassis.Components;
model InclinationResistance "Inclination resistance"
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  import Modelica.Constants.g_n;
  parameter Modelica.SIunits.Mass m "Total vehicle mass";
  Modelica.Blocks.Interfaces.RealInput inclination "Inclination"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  f = m*g_n*sin(atan(inclination));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
          Line(
            points={{-100,0},{100,0}},
            color={0,0,127}),
        Line(points={{-60,20},{60,60}},   color={28,108,200}),
        Line(points={{-60,20},{60,20}},   color={28,108,200})}),
                              Documentation(info="<html>
<p>
<pre>Inclination resistance = m * g * sin(atan(inclination))</pre>
<p>
</html>"));
end InclinationResistance;
