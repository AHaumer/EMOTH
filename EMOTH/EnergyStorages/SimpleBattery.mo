within EMOTH.EnergyStorages;
model SimpleBattery "Simple battery model"
  extends Interfaces.BaseElectricDevice(
    final includeGround=true,
    includeHeatPort=false,
    final usingMultiBodyChassis=false);
  extends EMOTH.Icons.EnergyStorage;
  import Modelica.Units.Conversions.from_Ah;
  parameter ParameterRecords.EnergyStorages.BatteryData batteryData
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  parameter Real SoC0(final min=0, final max=1)=1 "Initial state of charge"
    annotation(Dialog(group="Initialization"));
  output Modelica.Units.SI.Energy EDC=integratorEnergy.y
    "DC energy consumption";
  output Real SoC=integratorCharge.y/from_Ah(batteryData.QNominal) "State of charge";
  Modelica.Electrical.Analog.Sources.SignalVoltage   constantVoltage
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,80})));
  Sensors.ElectricalMulitSensorDC electricalMulitSensorDC(
    final invertV=false,
    final invertI=true,
    final invertP=true)  annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={40,80})));
  Modelica.Blocks.Continuous.Integrator integratorEnergy(final k=1)
    annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
  Modelica.Blocks.Continuous.Integrator integratorCharge(final k=-1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=SoC0*from_Ah(batteryData.QNominal))
    annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
  Modelica.Blocks.Math.Gain gain(k=1/from_Ah(batteryData.QNominal))
                                 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-60,-30})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(
    useHeatPort=true,
    final R=batteryData.Ri,
    final T_ref=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,80})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-20,-70})));
protected
  Interfaces.BatteryBus batteryBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,0})));
public
  Components.SoCdependentVoltage batteryVoltage(
    VDC=batteryData.VDC,
    VDCmin=batteryData.VDCmin,
    SoCmin=batteryData.SoCmin) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,50})));
equation
  assert(SoC<=1.001, "Battery overloaded!");
  assert(SoC>=batteryData.SoCmin, "Battery exhausted!");
  connect(controlBus.batteryBus, batteryBus) annotation (Line(
      points={{-100,-60},{-100,-60},{-100,0}},
      color={255,204,51},
      thickness=0.5));
  connect(integratorEnergy.y, batteryBus.EDC) annotation (Line(points={{-71,0},
          {-100.05,0},{-100.05,0.05}}, color={0,0,127}));
  connect(heatFlowSensor.Q_flow, batteryBus.Losses) annotation (Line(points={{-20,-60},
          {-20,-50},{-80,-50},{-80,0.05},{-100.05,0.05}},      color={0,0,127}));
  connect(integratorCharge.y, gain.u) annotation (Line(points={{-21,0},{-30,0},
          {-30,-30},{-48,-30}},color={0,0,127}));
  connect(gain.y, batteryBus.SoC) annotation (Line(points={{-71,-30},{-80,-30},{
          -80,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(pin_n, constantVoltage.n) annotation (Line(points={{-60,100},{-60,100},
          {-60,80},{-40,80}}, color={0,0,255}));
  connect(constantVoltage.p, resistor.p)
    annotation (Line(points={{-20,80},{-10,80},{0,80}}, color={0,0,255}));
  connect(resistor.n, electricalMulitSensorDC.nc)
    annotation (Line(points={{20,80},{30,80},{30,80}}, color={0,0,255}));
  connect(electricalMulitSensorDC.pc, pin_p)
    annotation (Line(points={{50,80},{60,80},{60,100}}, color={0,0,255}));
  connect(pin_n, electricalMulitSensorDC.nv) annotation (Line(points={{-60,100},
          {-10,100},{40,100},{40,90}}, color={0,0,255}));
  connect(resistor.heatPort, heatFlowSensor.port_a) annotation (Line(points={{10,
          70},{10,70},{10,-70},{10,-70},{-10,-70}}, color={191,0,0}));
  connect(electricalMulitSensorDC.power, integratorEnergy.u) annotation (Line(
        points={{34,69},{34,20},{-40,20},{-40,0},{-48,0}},         color={0,0,127}));
  connect(electricalMulitSensorDC.power, batteryBus.PDC) annotation (Line(
        points={{34,69},{34,20},{-100.05,20},{-100.05,0.05}},
        color={0,0,127}));
  connect(electricalMulitSensorDC.current, integratorCharge.u)
    annotation (Line(points={{40,69},{40,69},{40,0},{2,0}}, color={0,0,127}));
  connect(electricalMulitSensorDC.current, batteryBus.iDC) annotation (Line(
        points={{40,69},{40,20},{-100.05,20},{-100.05,0.05}},         color={0,0,
          127}));
  connect(electricalMulitSensorDC.voltage, batteryBus.vDC) annotation (Line(
        points={{46,69},{46,20},{-100.05,20},{-100.05,0.05}},         color={0,0,
          127}));
  connect(internalHeatPort, heatFlowSensor.port_b)
    annotation (Line(points={{-40,-70},{-35,-70},{-30,-70}}, color={191,0,0}));
  connect(batteryVoltage.y, constantVoltage.v)
    annotation (Line(points={{-30,61},{-30,73}}, color={0,0,127}));
  connect(gain.y, batteryVoltage.u) annotation (Line(points={{-71,-30},{-80,-30},
          {-80,30},{-30,30},{-30,38}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Simple model of a battery with constant no-load voltage and inner resistance. 
Additionally, the current is integrated to obtain charge (and state of charge) of the battery, and the power is integrated to show the exchanged amount of energy.
</p>
</html>"));
end SimpleBattery;
