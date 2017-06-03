within EMOTH.Drivers;
model ThrottleAndBrake "Throttle and brake command"
  extends Icons.Throttle;
  parameter Boolean ConstantBrake=true "cConstant mechanical brake, otherwise input";
  parameter Real fn_Brake=0 "Constant brake"
    annotation(Dialog(enable=ConstantBrake));
  parameter Boolean ConstantThrottle=false "Constant throttle, otherwise input";
  parameter Real Throttle=0.5 "Constant throttle"
    annotation(Dialog(enable=ConstantThrottle));
  parameter Boolean ConstantForward=true "Constant direction forward, otherwise input";
  parameter Boolean Forward=true "Constant direction = forward (false = backward)"
    annotation(Dialog(enable=ConstantForward));
  Interfaces.DriverInterface driverInterface annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,3.55271e-015})));
  Modelica.Blocks.Interfaces.RealInput brake if not ConstantBrake
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput throttle if not ConstantThrottle
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanInput forward if not ConstantForward
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Sources.Constant constantBrake(final k=fn_Brake) if ConstantBrake
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Modelica.Blocks.Sources.Constant constantThrottle(final k=Throttle) if ConstantThrottle
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.BooleanConstant constantForward(final k=Forward) if ConstantForward
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Nonlinear.Limiter limiterBrake(final uMax=1, final uMin=0)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Blocks.Nonlinear.Limiter limiterThrottle(final uMax=1, final uMin=0)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
protected
  Modelica.Blocks.Interfaces.BooleanInput forwardInternal
    annotation (Placement(transformation(extent={{-24,-64},{-16,-56}})));
public
  Blocks.DirectionSwitch directionSwitch
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
equation
  connect(brake, limiterBrake.u)
    annotation (Line(points={{-120,60},{-42,60}}, color={0,0,127}));
  connect(limiterBrake.u, constantBrake.y) annotation (Line(points={{-42,60},{-50,
          60},{-50,90},{-59,90}}, color={0,0,127}));
  connect(throttle, limiterThrottle.u)
    annotation (Line(points={{-120,0},{-42,0}}, color={0,0,127}));
  connect(limiterThrottle.u, constantThrottle.y) annotation (Line(points={{-42,0},
          {-50,0},{-50,30},{-59,30}}, color={0,0,127}));
  connect(limiterBrake.y, driverInterface.fn_brake) annotation (Line(points={{
          -19,60},{40,60},{100.1,60},{100.1,-0.1}}, color={0,0,127}));
  connect(forwardInternal, driverInterface.forward) annotation (Line(points={{-20,
          -60},{40,-60},{100.1,-60},{100.1,-0.1}}, color={255,0,255}));
  connect(constantForward.y, forwardInternal) annotation (Line(points={{-59,-30},
          {-50,-30},{-50,-60},{-20,-60}}, color={255,0,255}));
  connect(forward, forwardInternal) annotation (Line(points={{-120,-60},{-20,
          -60},{-20,-60}}, color={255,0,255}));
  connect(limiterThrottle.y, directionSwitch.u)
    annotation (Line(points={{-19,0},{-2,0}}, color={0,0,127}));
  connect(forwardInternal, directionSwitch.switch)
    annotation (Line(points={{-20,-60},{10,-60},{10,-12}}, color={255,0,255}));
  connect(directionSwitch.y, driverInterface.throttle)
    annotation (Line(points={{21,0},{100.1,0},{100.1,-0.1}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Feeds external signal or constant for throttle, brake signal and choice of direction (foward/backward) to the <a href=\"modelica://EMOTH.Interfaces.DriverInterface\">driver interface</a>.
</p>
</html>"));
end ThrottleAndBrake;
