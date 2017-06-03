within EMOTH.Sensors;
model TranslationalMultiSensor
  "Ideal sensor to measure the absolute acceleration, velocity, distance, force and power between two flanges"
  extends Modelica.Mechanics.Translational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput power(unit="W")
    "Power in flange as output signal" annotation (Placement(
        transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput f(unit="N")
    "Force in flange_a and flange_b (f = flange_a.f = -flange_b.f) as output signal"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,-110})));
  Modelica.Blocks.Interfaces.RealOutput s(unit="m")
    "Absolute position of flange as output signal" annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));
  Modelica.Blocks.Interfaces.RealOutput v(unit="m/s")
    "Absolute velocity of flange as output signal"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={42,-110})));
  Modelica.Blocks.Interfaces.RealOutput a(unit="m/s2")
    "Absolute acceleration of flange as output signal" annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={80,-110})));
equation
  flange_a.s = flange_b.s;
  f = flange_a.f;
  s = flange_a.s;
  v = der(flange_a.s);
  a = der(v);
  power = f*v;
  annotation (Documentation(info="<html>
<p>
Measures the <b>absolute position</b> ,<b>absolute velocity</b> and <b>absolute acceleration</b> of a flange_a, the <b>cut-force</b> and <b>power</b> between two flanges 
in an ideal way and provides the results as output signals <b>s</b>, <b>v</b>, <b>a</b>, <b>f</b> and <b>power</b>, respectively. </p>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
                                  Line(points={{-70,0},{-90,0}}, color={0,0,
          0}),Line(points={{70,0},{90,0}}),                        Text(
              extent={{-100,-60},{-60,-100}},
              lineColor={0,0,0},
          textString="P"),                                         Text(
              extent={{-60,-60},{-20,-100}},
              lineColor={0,0,0},
          textString="f"),                                         Text(
              extent={{-20,-60},{20,-100}},
              lineColor={0,0,0},
          textString="s"),                                         Text(
              extent={{20,-60},{60,-100}},
              lineColor={0,0,0},
          textString="v"),                                         Text(
              extent={{60,-60},{100,-100}},
              lineColor={0,0,0},
          textString="a")}));
end TranslationalMultiSensor;
