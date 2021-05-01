within EMOTH.DriveLines;
model RearAxleDrive
  "Central engine drives rear axle with differential"
  extends VehicleInterfaces.Drivelines.Interfaces.TwoAxleBase(
    final usingMultiBodyChassis=false, final usingMultiBodyTransmission=false);
  extends VehicleInterfaces.Icons.Driveline;
  parameter Boolean includeHeatPort = false "Include the driveline heat port"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter ParameterRecords.Vehicles.VehicleData vehicleData(
    m=261,
    aNominal=9,
    vNominal(displayUnit="km/h") = 22.222222222222,
    brakeFront=0.7,
    A=1.166,
    cw=0.3,
    rFront=0.2353,
    JFront=0.3,
    rRear=0.2353,
    JRear=0.3,
    ratioGear=5.1724,
    etaGear=0.99,
    etaDiff=0.98)
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Components.Differential differential annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={60,0})));
  Components.GearConstantEfficiency gearConstantEfficiency(ratio=vehicleData.ratioGear,
    final w_min=1e-6*vehicleData.wDriveNominal,
    final tau_min=1e-6*vehicleData.tauDriveNominal,
    eta=vehicleData.etaGear*vehicleData.etaDiff,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Sensors.RotationalMultiSensor rotationalMultiSensor_0
    annotation (Placement(transformation(extent={{-40,10},{-20,-10}})));
  Sensors.RotationalMultiSensor rotationalMultiSensor_3 annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={60,-50})));
  Sensors.RotationalMultiSensor rotationalMultiSensor_4 annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={60,50})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if includeHeatPort
    "Conditional port for exhaust heat flow"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
 Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final
      T=293.15) if not includeHeatPort annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-90,-30})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-70,-20})));
protected
  Interfaces.DriveLineBus driveLineBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,40})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort
    "Conditional port for exhaust heat flow"
    annotation (Placement(transformation(extent={{-102,-22},{-98,-18}})));
equation
  connect(gearConstantEfficiency.flange_b, differential.flange_a)
    annotation (Line(points={{10,0},{30,0},{50,0}}, color={0,0,0}));
  connect(controlBus.drivelineBus, driveLineBus) annotation (Line(
      points={{-100.1,60.1},{-100,60.1},{-100,40}},
      color={255,204,51},
      thickness=0.5));
  connect(rotationalMultiSensor_0.flange_a, transmissionFlange.flange)
    annotation (Line(points={{-40,0},{-99.95,0},{-99.95,0.05}}, color={0,0,0}));
  connect(rotationalMultiSensor_0.flange_b, gearConstantEfficiency.flange_a)
    annotation (Line(points={{-20,0},{-10,0}}, color={0,0,0}));
  connect(rotationalMultiSensor_4.flange_b, wheelHub_4.flange) annotation (Line(
        points={{60,60},{60,100.05},{59.95,100.05}}, color={0,0,0}));
  connect(rotationalMultiSensor_3.flange_b, wheelHub_3.flange) annotation (Line(
        points={{60,-60},{60,-99.95},{59.95,-99.95}}, color={0,0,0}));
  connect(rotationalMultiSensor_3.flange_a, differential.flange_b1)
    annotation (Line(points={{60,-40},{60,-10}},          color={0,0,0}));
  connect(differential.flange_b2, rotationalMultiSensor_4.flange_a)
    annotation (Line(points={{60,10},{60,25},{60,40}}, color={0,0,0}));
  connect(rotationalMultiSensor_0.a, driveLineBus.a_0) annotation (Line(points={
          {-22,11},{-22,40.05},{-100.05,40.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_0.w, driveLineBus.w_0) annotation (Line(points={
          {-25.8,11},{-25.8,40.05},{-100.05,40.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_0.tau, driveLineBus.tau_0) annotation (Line(
        points={{-34,11},{-34,11},{-34,40.05},{-100.05,40.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_0.power, driveLineBus.P_0) annotation (Line(
        points={{-38,11},{-38,11},{-38,40.05},{-100.05,40.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_3.a, driveLineBus.a_3) annotation (Line(points={
          {49,-58},{40,-58},{40,40.05},{-100.05,40.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_3.w, driveLineBus.w_3) annotation (Line(points={
          {49,-54.2},{40,-54.2},{40,40.05},{-100.05,40.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_3.tau, driveLineBus.tau_3) annotation (Line(
        points={{49,-46},{40,-46},{40,40.05},{-100.05,40.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_3.power, driveLineBus.P_3) annotation (Line(
        points={{49,-42},{40,-42},{40,40.05},{-100.05,40.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_4.a, driveLineBus.a_4) annotation (Line(points={
          {49,58},{40,58},{40,40.05},{-100.05,40.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_4.w, driveLineBus.w_4) annotation (Line(points={
          {49,54.2},{40,54.2},{40,40.05},{-100.05,40.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_4.tau, driveLineBus.tau_4) annotation (Line(
        points={{49,46},{40,46},{40,40.05},{-100.05,40.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_4.power, driveLineBus.P_4) annotation (Line(
        points={{49,42},{40,42},{40,40.05},{-100.05,40.05}}, color={0,0,127}));
  connect(heatPort, internalHeatPort) annotation (Line(points={{-100,-60},{-100,-20}},
                       color={191,0,0}));
  connect(internalHeatPort, fixedTemperature.port)
    annotation (Line(points={{-100,-20},{-90,-20},{-90,-24}}, color={191,0,0}));
  connect(internalHeatPort, heatFlowSensor.port_b)
    annotation (Line(points={{-100,-20},{-80,-20}}, color={191,0,0}));
  connect(heatFlowSensor.port_a, gearConstantEfficiency.heatPort) annotation (
      Line(points={{-60,-20},{-14,-20},{-14,10},{-10,10}}, color={191,0,0}));
  connect(heatFlowSensor.Q_flow, driveLineBus.Losses) annotation (Line(points={{-70,-9},{-70,-9},{-70,40.05},{-100.05,40.05}},
                                                       color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Model of a rear axle drive, driving both rear wheels by:
</p>
<ul>
<li>An <a href=\"modelica://EMOTH.DriveLines.Components.Differential\">ideal differential</a><(li>
<li>A <a href=\"modelica://EMOTH.DriveLines.Components.GearConstantEfficiency\">gearbox with constant efficiency</a><(li>
</ul>
<p>
The specified efficiency of the differential is additonally taken into acount in the gearbox. Total losses are dissipated either internally or to the optional heatport. 
</p>
</html>"));
end RearAxleDrive;
