within EMOTH.Drivers;
model Driver "Simple driver model"
  extends VehicleInterfaces.Icons.Driver;
  parameter Modelica.Units.SI.Time TPreview=0.75
    "Preview time for reference speed";
  parameter Real kp=1 "Proportional gain of PI driver controller";
  parameter Modelica.Units.SI.Time Ti=0.1
    "Integral time constant of PI driver controller";
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
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{20,-40},{0,-20}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{60,-50},{40,-30}})));
  Modelica.Blocks.Sources.Constant tPreview(final k=TPreview)
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Components.SplitPI splitPI
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(PID.u_s, driverInterface.vPreview) annotation (Line(points={{-22,0},{
          -30,0},{-30,20},{100.1,20},{100.1,-0.1}}, color={0,0,127}));
  connect(tPreview.y, driverInterface.tPreview) annotation (Line(points={{61,40},
          {100.1,40},{100.1,-0.1}}, color={0,0,127}));
  connect(add.y, PID.u_m)
    annotation (Line(points={{-1,-30},{-10,-30},{-10,-12}}, color={0,0,127}));
  connect(add.u1, driverInterface.v) annotation (Line(points={{22,-24},{100.1,
          -24},{100.1,-0.1}}, color={0,0,127}));
  connect(product.u1, driverInterface.a) annotation (Line(points={{62,-34},{
          100.1,-34},{100.1,-0.1}}, color={0,0,127}));
  connect(product.u2, driverInterface.tPreview) annotation (Line(points={{62,-46},
          {100.1,-46},{100.1,-0.1}},      color={0,0,127}));
  connect(add.u2, product.y) annotation (Line(points={{22,-36},{30,-36},{30,-40},
          {39,-40}}, color={0,0,127}));
  connect(PID.y, splitPI.u)
    annotation (Line(points={{1,0},{38,0}},        color={0,0,127}));
  connect(splitPI.forward, driverInterface.forward) annotation (Line(points={{
          62,0},{100.1,0},{100.1,-0.1}}, color={255,0,255}));
  connect(splitPI.fn_brake, driverInterface.fn_brake)
    annotation (Line(points={{61,6},{100.1,6},{100.1,-0.1}}, color={0,0,127}));
  connect(splitPI.throttle, driverInterface.throttle) annotation (Line(points={
          {61,-6},{100.1,-6},{100.1,-0.1}}, color={0,0,127}));
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
</html>"));
end Driver;
