within EMOTH.Chassis.Components;
model DragResistance "Quadratic dependency of force versus speed"
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  parameter Modelica.SIunits.Force f_nominal
    "Nominal force (if negative, force is acting as load)";
  parameter Modelica.SIunits.Velocity v_nominal(min=Modelica.Constants.eps)
    "Nominal speed";
  Modelica.SIunits.Velocity v
    "Velocity of flange with respect to support (= der(s))";
  Modelica.Blocks.Interfaces.RealInput vWind
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  v = der(s) - vWind;
  f = -f_nominal*smooth(1, if v >= 0 then (v/v_nominal)^2 else -(v/v_nominal)^2);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Line(
              points={{-100,-100},{-80,-98},{-60,-92},{-40,-82},{-20,-68},{
            0,-50},{20,-28},{40,-2},{60,28},{80,62},{100,100}},
              color={0,0,127},
              smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
Model of force, quadratic dependent on (velocity of flange - wind speed).<br>
Parameter ForceDirection chooses whether direction of force is the same in both directions of movement or not.
</p>
</html>"));
end DragResistance;
