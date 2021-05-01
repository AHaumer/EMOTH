within EMOTH.ElectricDrives;
model GenericDrive "Generic drive without losses"
  extends VehicleInterfaces.ElectricDrives.Interfaces.BaseDCMachine(final usingMultiBodySystem=false);
  extends EMOTH.Icons.ElectricDrive;
  parameter Boolean includeHeatPort = false "Include the drive heat port"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter ParameterRecords.ElectricDrives.GenericDrives.GenericDriveData
    driveData
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=driveData.J)
    annotation (Placement(transformation(extent={{40,10},{60,-10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={10,-20})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    T=driveData.T,
    initType=Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{-20,-30},{0,-50}})));
  Components.FieldWeakening fieldWeakening(
    wBase=driveData.wBase,
    tauBreakDown=driveData.tauBreakDown,
    tauMax=driveData.tauMax)
    annotation (Placement(transformation(extent={{-50,-30},{-30,-50}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=+1, uMin=-1)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-50}})));
  Sensors.RotationalMultiSensor rotationalMultiSensor
    annotation (Placement(transformation(extent={{70,10},{90,-10}})));
  Components.IdealPowerConverter idealPowerConverter(final useLosses=true)
    annotation (Placement(transformation(extent={{10,70},{-10,90}})));
  Sensors.ElectricalMultiSensorDC electricalMultiSensorDC
    annotation (Placement(transformation(extent={{40,90},{20,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if includeHeatPort
    "Conditional port for exhaust heat flow"
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
 Components.DriveEfficiency    driveEfficiency(
    final InverterEfficiency=driveData.InverterEfficiency,
    final useConstantMotorEfficiency=driveData.useConstantMotorEfficiency,
    final MotorEfficiency=driveData.MotorEfficiency,
    final tableName=driveData.tableName,
    final fileName=driveData.fileName,
    final tableSpeed_rpm=driveData.tableSpeed_rpm)
    annotation (Placement(transformation(extent={{40,30},{20,50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final
      T=293.15) if not includeHeatPort annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-40,-90})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-72,-80})));
protected
  Interfaces.ElectricMotorBus electricMotorBus annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,0})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort
    "Conditional port for exhaust heat flow"
    annotation (Placement(transformation(extent={{-42,-82},{-38,-78}})));
public
  Sensors.RotationalMultiSensor                     rotationalMultiSensor1
    annotation (Placement(transformation(extent={{10,10},{30,-10}})));
equation
  connect(firstOrder.y,torque. tau)
    annotation (Line(points={{1,-40},{10,-40},{10,-32}},
                                             color={0,0,127}));
  connect(fieldWeakening.y,firstOrder. u)
    annotation (Line(points={{-29,-40},{-26,-40},{-22,-40}},
                                             color={0,0,127}));
  connect(limiter.y,fieldWeakening. u)
    annotation (Line(points={{-59,-40},{-52,-40}},
                                               color={0,0,127}));
  connect(controlBus.electricMotorBus,electricMotorBus)  annotation (Line(
      points={{-100.1,-59.9},{-100,-59.9},{-100,0}},
      color={255,204,51},
      thickness=0.5));
  connect(fieldWeakening.w,electricMotorBus. w) annotation (Line(points={{-40,-28},
          {-40,20},{-90,20},{-90,0.05},{-100.05,0.05}},   color={0,0,127}));
  connect(rotationalMultiSensor.w,electricMotorBus. w) annotation (Line(points={{84.2,11},
          {84.2,20},{-90,20},{-90,0.05},{-100.05,0.05}},              color={0,0,
          127}));
  connect(rotationalMultiSensor.tau,electricMotorBus. tau) annotation (Line(
        points={{76,11},{76,11},{76,20},{-90,20},{-90,0.05},{-100.05,0.05}},
        color={0,0,127}));
  connect(rotationalMultiSensor.power,electricMotorBus. Pm) annotation (Line(
        points={{72,11},{72,20},{-90,20},{-90,0.05},{-100.05,0.05}},    color={0,
          0,127}));
  connect(limiter.u,electricMotorBus. throttle) annotation (Line(points={{-82,-40},
          {-90,-40},{-90,0},{-100.05,0},{-100.05,0.05}},
                                       color={0,0,127}));
  connect(idealPowerConverter.n, pin_n)
    annotation (Line(points={{-10,80},{-60,80},{-60,100}}, color={0,0,255}));
  connect(idealPowerConverter.p,electricalMultiSensorDC. nc)
    annotation (Line(points={{10,80},{15,80},{20,80}}, color={0,0,255}));
  connect(electricalMultiSensorDC.pc, pin_p)
    annotation (Line(points={{40,80},{60,80},{60,100}}, color={0,0,255}));
  connect(electricalMultiSensorDC.nv, pin_n) annotation (Line(points={{30,90},{
          30,90},{30,100},{-60,100}},
                                   color={0,0,255}));
  connect(electricalMultiSensorDC.voltage,electricMotorBus. vDC) annotation (
      Line(points={{36,69},{36,69},{36,60},{-90,60},{-90,0.05},{-100.05,0.05}},
        color={0,0,127}));
  connect(electricalMultiSensorDC.current,electricMotorBus. iDC) annotation (
      Line(points={{30,69},{30,60},{-90,60},{-90,0.05},{-100.05,0.05}}, color={0,
          0,127}));
  connect(electricalMultiSensorDC.power,electricMotorBus. Pel) annotation (Line(
        points={{24,69},{24,69},{24,60},{-90,60},{-90,0.05},{-100.05,0.05}},
        color={0,0,127}));
  connect(driveEfficiency.y, idealPowerConverter.Ploss)
    annotation (Line(points={{19,40},{6,40},{6,68}}, color={0,0,127}));
  connect(heatPort, internalHeatPort)
    annotation (Line(points={{-60,-100},{-60,-80},{-40,-80}}, color={191,0,0}));
  connect(internalHeatPort, prescribedHeatFlow.port)
    annotation (Line(points={{-40,-80},{-52,-80},{-62,-80}},
                                                           color={191,0,0}));
  connect(internalHeatPort, fixedTemperature.port)
    annotation (Line(points={{-40,-80},{-40,-84}},           color={191,0,0}));
  connect(driveEfficiency.y, electricMotorBus.Losses) annotation (Line(points={
          {19,40},{-90,40},{-90,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(driveEfficiency.y, prescribedHeatFlow.Q_flow) annotation (Line(points=
         {{19,40},{19,40},{-90,40},{-90,-80},{-82,-80}}, color={0,0,127}));
  connect(rotationalMultiSensor.flange_b, shaft_b.flange)
    annotation (Line(points={{90,0},{100.05,0},{100.05,0.05}}, color={0,0,0}));
  connect(inertia.flange_b, rotationalMultiSensor.flange_a)
    annotation (Line(points={{60,0},{65,0},{70,0}}, color={0,0,0}));
  connect(torque.flange, rotationalMultiSensor1.flange_a)
    annotation (Line(points={{10,-10},{10,-5},{10,0}}, color={0,0,0}));
  connect(rotationalMultiSensor1.flange_b, inertia.flange_a)
    annotation (Line(points={{30,0},{36,0},{40,0}}, color={0,0,0}));
  connect(rotationalMultiSensor1.power, idealPowerConverter.Pmechanical)
    annotation (Line(points={{12,11},{12,26},{0,26},{0,68}}, color={0,0,127}));
  connect(rotationalMultiSensor1.tau, driveEfficiency.tau) annotation (Line(
        points={{16,11},{16,26},{50,26},{50,34},{42,34}}, color={0,0,127}));
  connect(rotationalMultiSensor1.w, driveEfficiency.w) annotation (Line(points=
          {{24.2,11},{24.2,24},{52,24},{52,46},{42,46}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Generic model of an electric drive with constant efficiency:
</p>
<ul>
<li>The throttle signal is limited in the range [-1..+1].</li>
<li>From the limited throttle signal the torque demand is calculated by the <a href=\"modelica://EMOTH.ElectricDrives.Components.FieldWeakening\">field weakening block</a>, taking into account actual speed.</li>
<li>The torque demand goes through a PT1-block, representing the time constant of the current controlled drive.</li>
<li>The resulting torque demand is applied to the inertia of the motor and the shaft.</li>
<li>Based on the mechanical power, the losses are calculated by the <a href=\"modelica://EMOTH.ElectricDrives.Components.DriveEfficiency\">drive efficiency block</a>.</li>
<li>Based on the mechanical power and the losses, the <a href=\"modelica://EMOTH.ElectricDrives.Components.IdealPowerConverter\">ideal power converter</a> calculates the dc current, 
    taking actual dc voltage into account, based on a power balance.</li>
</ul>
<p>
Losses are dissipated either internally or to the optional heatport. 
</p>
</html>"));
end GenericDrive;
