within EMOTH.Icons;
partial model DrivingCycle "Basic graphical layout of driving cycle"


  annotation (Icon(graphics={   Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
                             Line(points={{-94,-60},{-74,-60},{-64,30},{-44,30},
              {-38,0},{-14,0},{-4,30},{16,30},{26,80},{36,80},{40,96},{60,96},{
              70,20},{74,-60},{94,-60}}, color={28,108,200},
          thickness=0.5),               Text(
        extent={{-140,-60},{140,-100}},
        textString="%name",
        lineColor={0,0,255})}));
end DrivingCycle;
