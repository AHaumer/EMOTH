within EMOTH.Sensors;
model RotationalMultiSensor
  "Ideal sensor to measure the absolute acceleration, velocity, distance, force and power between two flanges"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput power(unit="W")
    "Power in flange as output signal" annotation (Placement(
        transformation(
        origin={-80,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m")
    "Torque in flange_a and flange_b (tau = flange_a.tau = -flange_b.tau) as output signal"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,-110})));
  Modelica.Blocks.Interfaces.RealOutput phi(unit="rad")
    "Absolute angular positon of flange as output signal" annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));
  Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s")
    "Absolute angular velocity of flange as output signal"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={42,-110})));
  Modelica.Blocks.Interfaces.RealOutput a(unit="rad/s2")
    "Absolute angular acceleration of flange as output signal" annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={80,-110})));
equation
  flange_a.phi = flange_b.phi;
  tau = flange_a.tau;
  phi = flange_a.phi;
  w = der(flange_a.phi);
  a = der(w);
  power = tau*w;
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
          textString="tau"),                                       Text(
              extent={{-20,-60},{20,-100}},
              lineColor={0,0,0},
          textString="phi"),                                       Text(
              extent={{20,-60},{60,-100}},
              lineColor={0,0,0},
          textString="w"),                                         Text(
              extent={{60,-60},{100,-100}},
              lineColor={0,0,0},
          textString="a")}));
end RotationalMultiSensor;
