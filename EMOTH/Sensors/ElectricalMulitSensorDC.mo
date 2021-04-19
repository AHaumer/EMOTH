within EMOTH.Sensors;
model ElectricalMulitSensorDC
  "Sensor to measure DC voltage, current and power"
  extends Modelica.Icons.RoundSensor;
  parameter Boolean invertV=false "Invert voltage?";
  parameter Boolean invertI=false "Invert current?";
  parameter Boolean invertP=false "Invert power?";
  Modelica.Electrical.Analog.Interfaces.PositivePin pc
      "Positive pin, current path"
    annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin nc
      "Negative pin, current path"
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin nv
      "Negative pin, voltage path"
    annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
  Modelica.Blocks.Interfaces.RealOutput voltage(unit="V")
    "Instantaneous power as output signal" annotation (Placement(transformation(
        origin={-60,110},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
    annotation (Placement(transformation(
          origin={0,-70},
          extent={{10,10},{-10,-10}},
          rotation=90)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{-50,10},{-30,-10}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(
          origin={60,50},
          extent={{-10,-10},{10,10}},
          rotation=90)));

  Modelica.Blocks.Interfaces.RealOutput current(unit="A")
    "Instantaneous power as output signal" annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput power(unit="W")
    "Instantaneous power as output signal" annotation (Placement(transformation(
        origin={60,110},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Blocks.Math.Gain gainV(final k=if invertV then -1 else 1)
                                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,80})));
  Modelica.Blocks.Math.Gain gainI(final k=if invertI then -1 else 1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,80})));
  Modelica.Blocks.Math.Gain gainP(final k=if invertP then -1 else 1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,80})));
equation
  connect(voltageSensor.n, nv) annotation (Line(points={{-6.66134e-016,-80},{0,-80},
          {0,-100}},                              color={0,0,255}));
  connect(pc, currentSensor.p)
    annotation (Line(points={{-100,0},{-50,0}}, color={0,0,255}));
  connect(currentSensor.n, nc)
    annotation (Line(points={{-30,0},{100,0}}, color={0,0,255}));
  connect(voltageSensor.p, pc) annotation (Line(points={{0,-60},{0,-60},{0,-40},
          {-100,-40},{-100,0}}, color={0,0,255}));
  connect(voltageSensor.v, gainV.u) annotation (Line(points={{-10,-70},{-36,-70},
          {-60,-70},{-60,68}}, color={0,0,127}));
  connect(gainV.y, voltage) annotation (Line(points={{-60,91},{-60,91},{-60,110},
          {-60,110}}, color={0,0,127}));
  connect(currentSensor.i, gainI.u) annotation (Line(points={{-40,10},{-40,20},
          {0,20},{0,68}}, color={0,0,127}));
  connect(gainI.y, current)
    annotation (Line(points={{0,91},{0,110},{0,110}}, color={0,0,127}));
  connect(gainP.y, power)
    annotation (Line(points={{60,91},{60,110},{60,110}}, color={0,0,127}));
  connect(product.y, gainP.u)
    annotation (Line(points={{60,61},{60,64.5},{60,68}}, color={0,0,127}));
  connect(voltageSensor.v, product.u1) annotation (Line(points={{-10,-70},{-36,
          -70},{-60,-70},{-60,28},{54,28},{54,38}}, color={0,0,127}));
  connect(currentSensor.i, product.u2) annotation (Line(points={{-40,10},{-40,
          20},{66,20},{66,38}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
      Line(points = {{0,-70},{0,-100}}, color = {0,0,255}),
      Line(points = {{-100,0},{100,0}}, color = {0,0,255}),
      Text(lineColor = {0,0,255}, extent = {{-150,120},{150,160}}, textString = "%name"),
      Line(points = {{0,70},{0,40}}),
      Text(extent = {{-29,-70},{30,-11}}, textString = "P"),
        Text(
          extent={{-10,100},{10,80}},
          lineColor={28,108,200},
          textString="I"),
        Text(
          extent={{50,100},{70,80}},
          lineColor={28,108,200},
          textString="P"),
        Text(
          extent={{-70,100},{-50,80}},
          lineColor={28,108,200},
          textString="V")}),
    Documentation(info="<html>
<p>This power sensor measures instantaneous electrical power of a singlephase system and has a separated voltage and current path. The pins of the voltage path are pv and nv, the pins of the current path are pc and nc. The internal resistance of the current path is zero, the internal resistance of the voltage path is infinite.</p>
</html>", revisions="<html>
<ul>
<li><i>January 12, 2006</i> by Anton Haumer implemented</li>
</ul>
</html>"));
end ElectricalMulitSensorDC;
