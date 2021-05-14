within EMOTH.Drivers;
model CruiseControl "Simple cruise control model"
  extends Modelica.Icons.RoundSensor;
  parameter Modelica.Units.SI.Time T "Time constant of torque rise";
  parameter Modelica.Units.SI.Torque tauMax "Maximal torque of motor";
  parameter Modelica.Units.SI.Inertia J "Moment of inertia of motor";
  parameter Modelica.Units.SI.Length Rsub "Substitute wheel radius motor - track";
  parameter Modelica.Units.SI.Mass mDyn "Substitute (dynamic) mass";
  parameter Real kp=(mDyn + J/Rsub^2)/(2*T)/(tauMax/Rsub) "Proportional gain of speed controller";
  parameter Modelica.Units.SI.Time Ti=4*T "Integral time constant of speed controller";
  Modelica.Blocks.Continuous.LimPID PID(
    final k=kp,
    final Ti=Ti,
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final yMax=1,
    final yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Interfaces.DriverInterface driverInterface annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,3.55271e-015})));
  Modelica.Blocks.Sources.Constant tPreviewDummy(final k=0)
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Components.SplitPI splitPI
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(tPreviewDummy.y, driverInterface.tPreview) annotation (Line(points={{61,
          40},{100.1,40},{100.1,-0.1}}, color={0,0,127}));
  connect(PID.y, splitPI.u)
    annotation (Line(points={{1,0},{38,0}},        color={0,0,127}));
  connect(splitPI.forward, driverInterface.forward) annotation (Line(points={{
          62,0},{100.1,0},{100.1,-0.1}}, color={255,0,255}));
  connect(splitPI.fn_brake, driverInterface.fn_brake)
    annotation (Line(points={{61,6},{100.1,6},{100.1,-0.1}}, color={0,0,127}));
  connect(splitPI.throttle, driverInterface.throttle) annotation (Line(points={
          {61,-6},{100.1,-6},{100.1,-0.1}}, color={0,0,127}));
  connect(PID.u_s, driverInterface.vReference) annotation (Line(points={{-22,0},
          {-30,0},{-30,20},{100.1,20},{100.1,-0.1}}, color={0,0,127}));
  connect(PID.u_m, driverInterface.v) annotation (Line(points={{-10,-12},{-10,-20},
          {100.1,-20},{100.1,-0.1}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Gets information from the <a href=\"modelica://EMOTH.Interfaces.DriverInterface\">driver interface</a>:
</p>
<ul>
<li>reference speed</li>
<li>preview of reference speed (the preview time is communicated via the driver interface to the <a href=\"modelica://EMOTH.Drivers.DrivingCycle\">driving cycle</a>.</li>
<li>actual speed</li>
<li>actual acceleration</li>
</ul>
<p>
A PI-controller reacts on the control error = vRef(t + tPreview) - ( v(t) + a(t)*tPreview ). 
This signal is split into the throttle and the brake signal.
</p>
</html>"), Icon(graphics={
        Text(
          extent={{-100,-60},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString="%name"), Polygon(
          points={{-18,-5},{0,-19},{18,-5},{8,-5},{8,19},{-8,19},{-8,-5},{-18,-5}},

          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid,
          origin={42,79},
          rotation=-30)}));
end CruiseControl;
