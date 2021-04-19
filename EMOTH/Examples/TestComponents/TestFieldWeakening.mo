within EMOTH.Examples.TestComponents;
model TestFieldWeakening "Test field weakening block"
  extends Modelica.Icons.Example;
  import Modelica.Units.Conversions.from_rpm;
  output Modelica.Units.SI.Torque tauBreakDown=fieldWeakening.tauBreakDown*(if
      w.y < fieldWeakening.wBase then 1 else (fieldWeakening.wBase/w.y)^2);
  output Modelica.Units.SI.Torque tauMax=fieldWeakening.tauMax*(if w.y <
      fieldWeakening.wBase then 1 else (fieldWeakening.wBase/w.y));
  ElectricDrives.Components.FieldWeakening fieldWeakening(
    tauBreakDown=400,
    tauMax=200,
    wBase(displayUnit="rpm") = 104.71975511966)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant tau(k=1)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.Ramp w(duration=1, offset=0,
    height=from_rpm(5000))
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
equation
  connect(tau.y, fieldWeakening.u)
    annotation (Line(points={{-29,0},{-29,0},{-12,0}}, color={0,0,127}));
  connect(w.y, fieldWeakening.w)
    annotation (Line(points={{-19,-30},{0,-30},{0,-12}}, color={0,0,127}));
  annotation (experiment(Interval=0.0001), Documentation(info="<html>
<p>
Testing the <a href=\"modelica://EMOTH.ElectricDrives.Components.FieldWeakening\">field weakening block</a>.
</p>
<p>
This block receives a normalized torque reference [-1..+1] and calculates the torque reference depending on the actual speed.
</p>
</html>"));
end TestFieldWeakening;
