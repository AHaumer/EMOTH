within EMOTH.Accessories;
model RangeExtender "Simple model of a range extender"
  extends Interfaces.BaseElectricDevice(
    final includeGround=false,
    final includeHeatPort=false,
    final usingMultiBodyChassis=false);
  extends VehicleInterfaces.Icons.Engine;
  parameter Modelica.Units.SI.Power P=0 "Constant power production";
  parameter Real SoCLo=0.4 "Start REX when SoC falls below SoCLo";
  parameter Real SoCHi=0.8 "Stop  REX when SoC rises above SoCHi";
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    final uLow=SoCLo,
    final uHigh=SoCHi,
    final pre_y_start=true)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-30,40})));
  Modelica.Blocks.Sources.Constant constP(final k=-P)
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Blocks.Sources.Constant const0(final k=0)
    annotation (Placement(transformation(extent={{12,10},{-8,30}})));
  ElectricDrives.Components.IdealPowerConverter idealPowerConverter(final useLosses=false)
    annotation (Placement(transformation(extent={{-20,60},{-40,80}})));
  Sensors.ElectricalMultiSensorDC electricalMulitSensorDC
    annotation (Placement(transformation(extent={{40,80},{20,60}})));
  Modelica.Blocks.Continuous.Integrator integratorEnergy(final k=1)
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
protected
  Interfaces.RexBus rexBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,-60})));
  Interfaces.BatteryBus batteryBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,0})));
equation
  connect(pin_n, idealPowerConverter.n) annotation (Line(points={{-60,100},{-60,
          100},{-60,70},{-40,70}}, color={0,0,255}));
  connect(idealPowerConverter.p, electricalMulitSensorDC.nc)
    annotation (Line(points={{-20,70},{20,70}}, color={0,0,255}));
  connect(electricalMulitSensorDC.pc, pin_p) annotation (Line(points={{40,70},{50,
          70},{60,70},{60,100}}, color={0,0,255}));
  connect(electricalMulitSensorDC.nv, pin_n) annotation (Line(points={{30,80},{30,
          80},{30,100},{-60,100}}, color={0,0,255}));
  connect(electricalMulitSensorDC.power, integratorEnergy.u) annotation (Line(
        points={{24,59},{24,59},{24,-28},{24,-40},{58,-40}}, color={0,0,127}));
  connect(electricalMulitSensorDC.power, rexBus.PDC) annotation (Line(points={{
          24,59},{24,59},{24,-20},{100.05,-20},{100.05,-60.05}}, color={0,0,127}));
  connect(integratorEnergy.y, rexBus.EDC) annotation (Line(points={{81,-40},{90,
          -40},{100.05,-40},{100.05,-60.05}}, color={0,0,127}));
  connect(electricalMulitSensorDC.current, rexBus.iDC) annotation (Line(points=
          {{30,59},{30,59},{30,-20},{100.05,-20},{100.05,-60.05}}, color={0,0,
          127}));
  connect(electricalMulitSensorDC.voltage, rexBus.vDC) annotation (Line(points=
          {{36,59},{36,59},{36,-20},{100.05,-20},{100.05,-60.05}}, color={0,0,
          127}));
  connect(batteryBus, controlBus.batteryBus) annotation (Line(
      points={{-100,0},{-100,0},{-100,-60},{-100,-60}},
      color={255,204,51},
      thickness=0.5));
  connect(switch1.y, idealPowerConverter.Pmechanical)
    annotation (Line(points={{-30,51},{-30,58}},          color={0,0,127}));
  connect(constP.y, switch1.u3)
    annotation (Line(points={{-49,20},{-38,20},{-38,28}}, color={0,0,127}));
  connect(const0.y, switch1.u1)
    annotation (Line(points={{-9,20},{-22,20},{-22,28}}, color={0,0,127}));
  connect(hysteresis.y, switch1.u2)
    annotation (Line(points={{-69,0},{-30,0},{-30,28}}, color={255,0,255}));
  connect(hysteresis.u, batteryBus.SoC) annotation (Line(points={{-92,0},{-100.05,
          0},{-100.05,0.05}}, color={0,0,127}));
  connect(rexBus, controlBus.rexBus) annotation (Line(
      points={{100,-60},{-100.1,-60},{-100.1,-59.9}},
      color={255,204,51},
      thickness=0.5));
  annotation (Documentation(info="<html>
<p>
Simple model of a range extender feeding electrial energy when Soc falls below SoCLo until SoC rises above SoCHi.
</p>
</html>"));
end RangeExtender;
