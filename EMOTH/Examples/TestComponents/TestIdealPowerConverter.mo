within EMOTH.Examples.TestComponents;
model TestIdealPowerConverter "Test field weakening block"
  extends Modelica.Icons.Example;
  import Modelica.SIunits.Conversions.from_rpm;
  import Modelica.Constants.eps;
  output Modelica.SIunits.Power Pm=Pmechanical.y;
  output Modelica.SIunits.Power Pe=Pelectrical.power;
  output Modelica.SIunits.Power Ploss=constantEfficiency.y;
  output Real eff=if noEvent(Pm > eps) then Pm/Pe elseif noEvent(Pm < -eps) then Pe/Pm else 1;
  Modelica.Electrical.Analog.Basic.Resistor resistor(
    final R=0.01,
    final T_ref=293.15,
    useHeatPort=false)  annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,20})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(final V=
        100)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,0})));
  ElectricDrives.Components.IdealPowerConverter idealPowerConverter annotation (
     Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={0,0})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
  ElectricDrives.Components.ConstantEfficiency constantEfficiency(eta=0.9,
      p_min=1)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Electrical.Analog.Sensors.PowerSensor Pelectrical
    annotation (Placement(transformation(extent={{40,10},{20,30}})));
  Modelica.Blocks.Sources.Ramp Pmechanical(
    height=-20000,
    duration=1,
    offset=10000)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
equation
  connect(resistor.p, constantVoltage.p)
    annotation (Line(points={{70,20},{80,20},{80,10}}, color={0,0,255}));
  connect(constantVoltage.n, ground.p)
    annotation (Line(points={{80,-10},{80,-20},{80,-20}}, color={0,0,255}));
  connect(Pelectrical.pv, Pelectrical.pc)
    annotation (Line(points={{30,30},{40,30},{40,20}}, color={0,0,255}));
  connect(Pelectrical.pc, resistor.n)
    annotation (Line(points={{40,20},{45,20},{50,20}}, color={0,0,255}));
  connect(Pelectrical.nv, ground.p) annotation (Line(points={{30,10},{30,10},{30,
          -20},{80,-20}}, color={0,0,255}));
  connect(Pelectrical.nc, idealPowerConverter.p)
    annotation (Line(points={{20,20},{0,20},{0,10}}, color={0,0,255}));
  connect(ground.p, idealPowerConverter.n) annotation (Line(points={{80,-20},{
          40,-20},{0,-20},{0,-10}}, color={0,0,255}));
  connect(constantEfficiency.y, idealPowerConverter.Ploss) annotation (Line(
        points={{-29,20},{-20,20},{-20,6},{-12,6}}, color={0,0,127}));
  connect(Pmechanical.y, constantEfficiency.u) annotation (Line(points={{-69,0},
          {-60,0},{-60,20},{-52,20}}, color={0,0,127}));
  connect(Pmechanical.y, idealPowerConverter.Pmechanical)
    annotation (Line(points={{-69,0},{-12,0}}, color={0,0,127}));
  annotation (experiment(Interval=0.0001), Documentation(info="<html>
<p>
Testing an <a href=\"modelica://EMOTH.ElectricDrives.Components.IdealPowerConverter\">ideal power converter</a>.
</p>
<p>
This block receives the mechanical power and the losses as signals and prescribes the DC current consumption on DC side, dependent on DC voltage.
</p>
</html>"));
end TestIdealPowerConverter;
