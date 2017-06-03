within EMOTH.Interfaces;
partial model BaseElectricDevice
  "Basic interface for electric devices"
  parameter Boolean includeGround=false
    "Include inner electrical ground at pin_n"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean includeHeatPort = false "Include the battery heat port"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean usingMultiBodyChassis=false
    "Include secondary ground node on the right port"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

  ControlBus controlBus if not usingMultiBodyChassis
    "Control signal bus"
    annotation (Placement(transformation(
        origin={-100,-60},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
    "Positive electrical pin" annotation (Placement(transformation(extent={{50,90},
            {70,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
    "Negative electrical pin" annotation (Placement(transformation(extent={{-50,90},
            {-70,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if includeHeatPort
    "Conditional port for exhaust heat flow"
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
protected
  Modelica.Electrical.Analog.Basic.Ground ground if includeGround
    "Conditional electrical ground"
  annotation (Placement(transformation(extent={{-70,80},{-90,100}})));
 Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final T=293.15) if not includeHeatPort annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-40,-90})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort
    "Conditional port for exhaust heat flow"
    annotation (Placement(transformation(extent={{-42,-72},{-38,-68}})));

equation
  connect(ground.p, pin_n) annotation (Line(
      points={{-80,100},{-60,100}},
      color={0,0,255}));
  connect(fixedTemperature.port, internalHeatPort)
    annotation (Line(points={{-40,-84},{-40,-77},{-40,-70}}, color={191,0,0}));
  connect(internalHeatPort, heatPort) annotation (Line(points={{-40,-70},{-60,-70},
          {-60,-100}}, color={191,0,0}));
  annotation (                           Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
                            graphics={
        Line(
          visible=includeGround,
          points={{70,-106},{130,-106}},
          color={0,0,255}),
        Line(
          visible=includeGround,
          points={{85,-115},{115,-115}},
          color={0,0,255}),
        Line(
          visible=includeGround,
          points={{95,-123},{105,-123}},
          color={0,0,255}),
        Line(visible=includeGround,
          points={{100,-106},{100,-62}},
          color={0,0,255})}),
    Documentation(info="<html>
<p>This partial model defines the interfaces required for an electrical device subsystem. 
Additionally, the ground is connected to the connector pin_n. It can be disabled when <code>includeGround=false</code>. 
Additionally, the losses can be fec to the heat port. It can be disabled when <code>includeHeatPort=false</code>.
</p>
</html>"));
end BaseElectricDevice;
