within EMOTH.Examples.TestComponents;
model TestCombiTable1Dse "Test CombiTable1Dse"
  extends Modelica.Icons.Example;
  Blocks.CombiTable1Dse combiTable1Dse(table=[0,0; 0.1,0.1; 0.9,0.1; 1,0; 2,0;
        2.1,-0.1; 2.9,-0.1; 3,0], extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp ramp(          duration=1, height=7)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
equation
  connect(ramp.y, combiTable1Dse.u)
    annotation (Line(points={{-29,0},{-12,0}}, color={0,0,127}));
  annotation (experiment(Interval=0.0001), Documentation(info="<html>
<p>
Testing the <a href=\"modelica://EMOTH.Blocks.CombiTable1Dse\">1-dimensional extended 1-dimensional combi table</a>.
</p>
</html>"));
end TestCombiTable1Dse;
