within EMOTH.Icons;
partial model EnergyStorage
  "Basic graphical layout of energy storage"

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
          100,100}}), graphics={Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,-40},{40,-80}},
          lineColor={0,127,0},
          fillColor={0,255,0},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{-40,60},{40,-60}},
          lineColor={0,127,0},
          fillColor={0,255,0},
          fillPattern=FillPattern.VerticalCylinder),
        Ellipse(
          extent={{-40,80},{40,40}},
          lineColor={0,127,0},
          fillColor={0,255,0},
          fillPattern=FillPattern.Sphere),
        Text(
          extent={{-100,-60},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Ellipse(
          extent={{-20,70},{20,50}},
          lineColor={0,127,0},
          fillColor={0,255,0},
          fillPattern=FillPattern.Sphere)}),
  Documentation(info="<html>
</html>"));
end EnergyStorage;
