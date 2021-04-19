within EMOTH.Accessories;
model ElectricalAccessories
  "Simple model of electrical power consumption"
  extends Interfaces.BaseElectricDevice(
    final includeGround=false,
    final includeHeatPort=false,
    final usingMultiBodyChassis=false);
  extends VehicleInterfaces.Icons.Accessories;
  parameter Boolean useConstantPower=true "Use constant power consumpton, otherwise input";
  parameter Modelica.Units.SI.Power P=0 "Constant power consumption"
    annotation (Dialog(enable=useConstantPower));
  Modelica.Blocks.Interfaces.RealInput p if not useConstantPower
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Math.Gain gain(final k=1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Constant const(final k=P) if useConstantPower
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  ElectricDrives.Components.IdealPowerConverter idealPowerConverter(final useLosses=false)
    annotation (Placement(transformation(extent={{-20,60},{-40,80}})));
  Sensors.ElectricalMulitSensorDC electricalMulitSensorDC
    annotation (Placement(transformation(extent={{40,80},{20,60}})));
  Modelica.Blocks.Continuous.Integrator integratorEnergy(final k=1)
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
protected
  Interfaces.AccessoriesBus accessoriesBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,-60})));
equation
  connect(pin_n, idealPowerConverter.n) annotation (Line(points={{-60,100},{-60,
          100},{-60,70},{-40,70}}, color={0,0,255}));
  connect(idealPowerConverter.p, electricalMulitSensorDC.nc)
    annotation (Line(points={{-20,70},{20,70}}, color={0,0,255}));
  connect(electricalMulitSensorDC.pc, pin_p) annotation (Line(points={{40,70},{50,
          70},{60,70},{60,100}}, color={0,0,255}));
  connect(electricalMulitSensorDC.nv, pin_n) annotation (Line(points={{30,80},{30,
          80},{30,100},{-60,100}}, color={0,0,255}));
  connect(gain.y, idealPowerConverter.Pmechanical)
    annotation (Line(points={{-39,0},{-30,0},{-30,58}}, color={0,0,127}));
  connect(p, gain.u)
    annotation (Line(points={{-120,0},{-62,0},{-62,0}}, color={0,0,127}));
  connect(const.y, gain.u) annotation (Line(points={{-79,30},{-70,30},{-70,0},{-62,
          0}}, color={0,0,127}));
  connect(accessoriesBus, controlBus.accessoriesBus) annotation (Line(
      points={{100,-60},{-100,-60},{-100,-60}},
      color={255,204,51},
      thickness=0.5));
  connect(electricalMulitSensorDC.power, integratorEnergy.u) annotation (Line(
        points={{24,59},{24,59},{24,-28},{24,-40},{58,-40}}, color={0,0,127}));
  connect(electricalMulitSensorDC.power, accessoriesBus.PDC) annotation (Line(
        points={{24,59},{24,59},{24,-20},{100.05,-20},{100.05,-60.05}}, color={0,
          0,127}));
  connect(integratorEnergy.y, accessoriesBus.EDC) annotation (Line(points={{81,-40},
          {90,-40},{100.05,-40},{100.05,-60.05}}, color={0,0,127}));
  connect(electricalMulitSensorDC.current, accessoriesBus.iDC) annotation (Line(
        points={{30,59},{30,59},{30,-20},{100.05,-20},{100.05,-60.05}}, color={0,
          0,127}));
  connect(electricalMulitSensorDC.voltage, accessoriesBus.vDC) annotation (Line(
        points={{36,59},{36,59},{36,-20},{100.05,-20},{100.05,-60.05}}, color={0,
          0,127}));
  annotation (Documentation(info="<html>
<p>
Simple model of electrical power consumption, either constant or given by the input signal.
</p>
</html>"));
end ElectricalAccessories;
