within EMOTH.Tracks.Components;
block XzPosition
  "Calculates accumulated x and z position from inclination and speed"
  extends Modelica.Blocks.Icons.Block;
  parameter Real x0=0 "Initial value of x-Position";
  parameter Real z0=0 "Initial value of z-Position";
  Modelica.Blocks.Math.Atan atan
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Math.Sin sin
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Blocks.Math.Cos cos
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Blocks.Math.Product productx
    annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  Modelica.Blocks.Continuous.Integrator integratorx(
    final k=1,
    final initType=Modelica.Blocks.Types.Init.InitialOutput,
    final y_start=x0)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Blocks.Math.Product productz
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
  Modelica.Blocks.Continuous.Integrator integratorz(
    final k=1,
    final initType=Modelica.Blocks.Types.Init.InitialOutput,
    final y_start=z0)
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Modelica.Blocks.Interfaces.RealInput inclination
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput v
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput z
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput x
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
protected
  Integer updown=if inclination>1e-9 then 1 elseif inclination<-1e-9 then -1 else 0;
equation
  connect(atan.y, sin.u)
    annotation (Line(points={{-59,60},{-42,60}},   color={0,0,127}));
  connect(atan.y, cos.u) annotation (Line(points={{-59,60},{-52,60},{-52,-20},{
          -42,-20}},
               color={0,0,127}));
  connect(productz.y, integratorz.u)
    annotation (Line(points={{31,40},{38,40}}, color={0,0,127}));
  connect(productx.y, integratorx.u)
    annotation (Line(points={{31,-40},{38,-40}}, color={0,0,127}));
  connect(sin.y, productz.u1) annotation (Line(points={{-19,60},{-10,60},{-10,
          46},{8,46}}, color={0,0,127}));
  connect(cos.y, productx.u1) annotation (Line(points={{-19,-20},{-10,-20},{-10,
          -34},{8,-34}}, color={0,0,127}));
  connect(atan.u, inclination)
    annotation (Line(points={{-82,60},{-120,60}}, color={0,0,127}));
  connect(v, productx.u2) annotation (Line(points={{-120,-60},{-60,-60},{0,-60},
          {0,-46},{8,-46}}, color={0,0,127}));
  connect(integratorz.y, z) annotation (Line(points={{61,40},{80,40},{80,60},{
          110,60}}, color={0,0,127}));
  connect(v, productz.u2) annotation (Line(points={{-120,-60},{-62,-60},{0,-60},
          {0,34},{8,34}}, color={0,0,127}));
  connect(integratorx.y, x) annotation (Line(points={{61,-40},{80,-40},{80,-60},
          {110,-60}}, color={0,0,127}));
  annotation (Icon(graphics={        Text(
          extent={{-100,-40},{-60,-80}},
          lineColor={28,108,200},
          textString="v"),   Text(
          extent={{60,-40},{100,-80}},
          lineColor={28,108,200},
          textString="x"),           Text(
          extent={{60,80},{100,40}},
          lineColor={28,108,200},
          textString="z"),   Text(
          extent={{-100,80},{-20,40}},
          lineColor={28,108,200},
          textString="inc")}), Documentation(info="<html>
<p>
Calculates accumulated horizontal x-position and vertical z-position along the track from speed and inclination.
</p>
</html>"));
end XzPosition;
