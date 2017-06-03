within EMOTH.Drivers.Components;
block SplitPI "Split PI output to throttle and brake"
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput fn_brake
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput throttle
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.BooleanInput forward
    annotation (Placement(transformation(extent={{140,-20},{100,20}})));
equation
  if forward then
    fn_brake =-min(0, u);
    throttle = max(0, u);
  else
    fn_brake = max(0, u);
    throttle = min(0, u);
  end if;
  annotation (Documentation(info="<html>
<p>
Splits driver PI controller ouput [-1..+1] dependent on direction (forward/backward) to throttle signal [0..+1]/[0..-1] and brake signal [0..1]
</p>
</html>"));
end SplitPI;
