within EMOTH.Drivers.Components;
model RecuperationController
  "Partial control of throttle and brake signal"
  extends VehicleInterfaces.Icons.Controller;
  parameter Boolean useRecuperation "Braking with recuperation, otherwise mechanical?";
  parameter Real SoCLo=0.980 "Recuperate below SoCLo, above use mechanical brake";
  Interfaces.DriverInterface driverInterface annotation (Placement(
        transformation(
        extent={{-20,20},{20,-20}},
        rotation=270,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealOutput fn_brake
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput throttle
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
protected
  constant Real SoCHi=0.999;
  Boolean SoCLim = not pre(SoCLim) and SoC.y>SoCHi or pre(SoCLim) and SoC.y>=SoCLo;
  constant Real vMin=0.5;
  Boolean vLim = abs(v.y)<vMin;
  Modelica.Blocks.Routing.RealPassThrough  v
    annotation (Placement(transformation(extent={{-66,-46},{-54,-34}})));
  Modelica.Blocks.Routing.BooleanPassThrough  Forward
    annotation (Placement(transformation(extent={{-66,-26},{-54,-14}})));
  Modelica.Blocks.Routing.RealPassThrough  SoC
    annotation (Placement(transformation(extent={{-66,-6},{-54,6}})));
  Modelica.Blocks.Routing.RealPassThrough  Throttle
    annotation (Placement(transformation(extent={{-66,14},{-54,26}})));
  Modelica.Blocks.Routing.RealPassThrough  Fn_brake
    annotation (Placement(transformation(extent={{-66,34},{-54,46}})));
initial equation
  pre(SoCLim)=SoC.y>SoCHi;
equation
  if not useRecuperation or SoCLim or vLim then
    throttle = Throttle.y;
    fn_brake = Fn_brake.y;
  else
    throttle = Throttle.y + Fn_brake.y*(if Forward.y then -1 else 1);
    fn_brake = 0;
  end if;
  connect(Fn_brake.u, driverInterface.fn_brake) annotation (Line(points={{-67.2,
          40},{-80,40},{-80,-0.1},{-100.1,-0.1}}, color={0,0,127}));
  connect(Throttle.u, driverInterface.throttle) annotation (Line(points={{-67.2,
          20},{-80,20},{-80,-0.1},{-100.1,-0.1}}, color={0,0,127}));
  connect(SoC.u, driverInterface.SoC) annotation (Line(points={{-67.2,0},{-100.1,
          0},{-100.1,-0.1}}, color={0,0,127}));
  connect(Forward.u, driverInterface.forward) annotation (Line(points={{-67.2,-20},
          {-80,-20},{-80,-0.1},{-100.1,-0.1}}, color={255,0,255}));
  connect(v.u, driverInterface.v) annotation (Line(points={{-67.2,-40},{-80,-40},
          {-80,-0.1},{-100.1,-0.1}}, color={0,0,127}));
   annotation (Documentation(info="<html>
<p>
Simple logic to distribute a signal from the driver to the throttle and braking signals.
</p>
<p>
Throttle signal is alway sent to the drive. The brake signal depends on useRecuperation, SoC and speed:
<ul>
<li>If useRecuperation is false or SoC is above SoCmax or speed is below vMin, braking signal is sent to the mechanical brakes.</li>
<li>Otherwise braking energy is recuperated.</li>
</ul>
Near zero speed, braking has to be done by the mechanical brakes, otherwise the vehicle could accelerate in the opposite direction.
</p>
</html>"));
end RecuperationController;
