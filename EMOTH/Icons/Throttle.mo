within EMOTH.Icons;
partial block Throttle "Basic graphical layout of throttle with brake"

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
          100,100}}), graphics={Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Text(
        extent={{-140,-60},{140,-100}},
        textString="%name",
        lineColor={0,0,255}),
        Polygon(
          points={{-50,30},{-30,30},{-28,34},{62,50},{70,60},{70,64},{60,54},{
              -30,40},{-50,30}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,30},{-30,-30}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,20},{68,-20}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder)}),
  Documentation(info="<html>
</html>"));
end Throttle;
