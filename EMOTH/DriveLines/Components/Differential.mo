within EMOTH.DriveLines.Components;
model Differential "Simple model of a differential"

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a "driving flange"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b1
    "driven flange 1 (left)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b2
    "driven flange 2 (right)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Mechanics.Rotational.Components.IdealPlanetary idealPlanetary(final
      ratio=-2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-30})));
equation
  /*
  2*flange_a.phi = flange_b1.phi + flange_b2.phi;
  flange_b2.tau = flange_b1.tau;
  flange_a.tau = -(flange_b1.tau + flange_b2.tau);
  */
  connect(flange_a, idealPlanetary.ring)
    annotation (Line(points={{0,-100},{0,-40}}, color={0,0,0}));
  connect(idealPlanetary.sun, flange_b1) annotation (Line(points={{1.77636e-15,-20},
          {1.77636e-15,0},{-100,0}}, color={0,0,0}));
  connect(idealPlanetary.carrier, flange_b2)
    annotation (Line(points={{4,-20},{4,0},{100,0}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Sphere),
        Text(
          extent={{-100,100},{100,60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={135,135,135},
          textString="%name"),
        Rectangle(
          extent={{-10,-58},{10,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={135,135,135}),
        Rectangle(
          extent={{-100,10},{-58,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={135,135,135}),
        Rectangle(
          extent={{58,10},{100,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={135,135,135}),
        Text(
          extent={{-100,-20},{-80,-40}},
          lineColor={0,0,0},
          textString="1"),
        Text(
          extent={{80,-20},{100,-40}},
          lineColor={0,0,0},
          textString="2")}),          Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Ideal model of a differential without losses (compare <a href=\"modelica://Modelica.Mechanics.Rotational.Components.IdealPlanetary\">Modelica.Mechanics.Rotational.Components.IdealPlanetary</a>)
</p>
</html>"));
end Differential;
