within EMOTH.Examples.TestComponents;
model TestDifferential "Test differential"
  extends Modelica.Icons.Example;
  DriveLines.Components.Differential differential annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={50,0})));
  Sensors.RotationalMultiSensor rotationalMultiSensor
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Sensors.RotationalMultiSensor rotationalMultiSensor1 annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,-30})));
  Sensors.RotationalMultiSensor rotationalMultiSensor2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,30})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia1(J=1) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,-62})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,60})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=1) annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-10,0})));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=20,
    offset=-10,
    period=2)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
    linearSpeedDependentTorque1(
    TorqueDirection=false,
    w_nominal=1,
    tau_nominal=-5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-90})));
  Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
    linearSpeedDependentTorque2(
    TorqueDirection=false,
    w_nominal=1,
    tau_nominal=-5) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,90})));
equation
  connect(rotationalMultiSensor.flange_b, differential.flange_a)
    annotation (Line(points={{30,0},{40,0}}, color={0,0,0}));
  connect(rotationalMultiSensor2.flange_a, differential.flange_b2)
    annotation (Line(points={{50,20},{50,15},{50,10}}, color={0,0,0}));
  connect(differential.flange_b1, rotationalMultiSensor1.flange_a)
    annotation (Line(points={{50,-10},{50,-15},{50,-20}}, color={0,0,0}));
  connect(inertia2.flange_a, rotationalMultiSensor2.flange_b)
    annotation (Line(points={{50,50},{50,45},{50,40}}, color={0,0,0}));
  connect(rotationalMultiSensor1.flange_b, inertia1.flange_a)
    annotation (Line(points={{50,-40},{50,-46},{50,-52}}, color={0,0,0}));
  connect(pulse.y, torque.tau)
    annotation (Line(points={{-59,0},{-55.5,0},{-52,0}}, color={0,0,127}));
  connect(inertia.flange_b, rotationalMultiSensor.flange_a)
    annotation (Line(points={{0,0},{10,0}}, color={0,0,0}));
  connect(linearSpeedDependentTorque2.flange, inertia2.flange_b)
    annotation (Line(points={{50,80},{50,75},{50,70}}, color={0,0,0}));
  connect(inertia1.flange_b, linearSpeedDependentTorque1.flange)
    annotation (Line(points={{50,-72},{50,-80}}, color={0,0,0}));
  connect(inertia.flange_a, torque.flange)
    annotation (Line(points={{-20,0},{-30,0},{-30,0}}, color={0,0,0}));
  annotation (experiment(StopTime=10, Interval=0.01), Documentation(info="<html>
<p>
Testing a simple <a href=\"modelica://EMOTH.DriveLines.Components.Differential\">differential gear</a>.
</p>
<p>
If you reduce the braking torque at one wheel, this wheel will rotate faster and the other one slower.
</p>
</html>"));
end TestDifferential;
