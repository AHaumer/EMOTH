within EMOTH.Examples.TestComponents;
model TestGearConstantEffciency "Test gearbox with constant efficiency"
  extends Modelica.Icons.Example;
  DriveLines.Components.GearConstantEfficiency gearConstantEfficiency(
    ratio=2,
    eta=0.8,
    w_min=1,
    tau_min=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Sensors.RotationalMultiSensor rotationalMultiSensor_a
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Sensors.RotationalMultiSensor rotationalMultiSensor_b
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=20,
    offset=-10,
    period=10)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed(exact=true)
    annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=20,
    rising=1,
    width=1.5,
    falling=1,
    period=5,
    offset=-10)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
equation
  connect(gearConstantEfficiency.flange_b, rotationalMultiSensor_b.flange_a)
    annotation (Line(points={{10,0},{20,0}}, color={0,0,0}));
  connect(rotationalMultiSensor_a.flange_b, gearConstantEfficiency.flange_a)
    annotation (Line(points={{-20,0},{-15,0},{-10,0}},
                                                    color={0,0,0}));
  connect(torque.flange, rotationalMultiSensor_a.flange_a)
    annotation (Line(points={{-50,0},{-45,0},{-40,0}}, color={0,0,0}));
  connect(pulse.y, torque.tau)
    annotation (Line(points={{-79,0},{-72,0}}, color={0,0,127}));
  connect(speed.flange, rotationalMultiSensor_b.flange_b)
    annotation (Line(points={{50,0},{45,0},{40,0}}, color={0,0,0}));
  connect(speed.w_ref, trapezoid.y)
    annotation (Line(points={{72,0},{79,0}}, color={0,0,127}));
  annotation (experiment(StopTime=10, Interval=0.01), Documentation(info="<html>
<p>
Testing a <a href=\"modelica://EMOTH.DriveLines.Components.GearConstantEfficiency\">gearbox with constant efficiency</a>.
</p>
</html>"));
end TestGearConstantEffciency;
