within EMOTH.Icons;
partial model ElectricDrive
  "Basic graphical layout of electric drive"

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
          100,100}}), graphics={Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Rectangle(
          lineColor={82,0,2},
          fillColor={252,37,57},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-90,-50},{40,50}},
          radius=10.0),
        Rectangle(
          lineColor={64,64,64},
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{40,-10},{90,10}}),
        Text(
          extent={{-100,-60},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Polygon(
          fillColor={64,64,64},
          fillPattern=FillPattern.Solid,
          points={{-90,-60},{-80,-60},{-50,-30},{0,-30},{30,-60},{40,-60},{40,
              -70},{-90,-70},{-90,-60}})}),
  Documentation(info="<html>
</html>"));
end ElectricDrive;
