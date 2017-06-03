within EMOTH.Brakes;
model Brakes4wheels "Simple brake model 4 wheels"
  import EMo = EMOTH;
  extends VehicleInterfaces.Brakes.Interfaces.TwoAxleBase(final usingMultiBodyChassis=false);
  extends VehicleInterfaces.Icons.Brakes;
  parameter Boolean includeHeatPort = false "Include the brake heat port"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter EMo.ParameterRecords.Vehicles.VehicleData vehicleData
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Mechanics.Rotational.Components.Brake brake_1(final cgeo=2, final
      fn_max=vehicleData.tauBrakeFront/2)
                         annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-60,-40})));
  Modelica.Mechanics.Rotational.Components.Brake brake_2(final cgeo=2, final
      fn_max=vehicleData.tauBrakeFront/2)
                         annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-60,40})));
  Modelica.Mechanics.Rotational.Components.Brake brake_3(final cgeo=2, final
      fn_max=vehicleData.tauBrakeRear/2)
                        annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={60,-40})));
  Modelica.Mechanics.Rotational.Components.Brake brake_4(final cgeo=2, final
      fn_max=vehicleData.tauBrakeRear/2)
                        annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,40})));
  EMo.Sensors.RotationalMultiSensor rotationalMultiSensor_1 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-60,-70})));
  EMo.Sensors.RotationalMultiSensor rotationalMultiSensor_2 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,70})));
  EMo.Sensors.RotationalMultiSensor rotationalMultiSensor_3 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-70})));
  EMo.Sensors.RotationalMultiSensor rotationalMultiSensor_4 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={60,70})));
  Components.SimpleController simpleController
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=4)
    annotation (Placement(transformation(extent={{36,-6},{24,6}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if includeHeatPort
    "Conditional port for exhaust heat flow"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final
      T=293.15) if not includeHeatPort annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-90,-30})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-60,-30},{-80,-10}})));
  Modelica.Blocks.Math.Gain gain(final k=-1) annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-30,20})));
protected
  Interfaces.BrakesBus brakesBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,0})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalHeatPort
    "Conditional port for exhaust heat flow"
    annotation (Placement(transformation(extent={{-102,-22},{-98,-18}})));
equation
  connect(controlBus.brakesBus, brakesBus) annotation (Line(
      points={{-100.1,60.1},{-100,60.1},{-100,0}},
      color={255,204,51},
      thickness=0.5));
  connect(brake_1.flange_a, rotationalMultiSensor_1.flange_a)
    annotation (Line(points={{-60,-50},{-60,-55},{-60,-60}}, color={0,0,0}));
  connect(rotationalMultiSensor_1.flange_b, wheelHub_1.flange) annotation (Line(
        points={{-60,-80},{-60,-99.95},{-60.05,-99.95}}, color={0,0,0}));
  connect(rotationalMultiSensor_2.flange_b, wheelHub_2.flange) annotation (Line(
        points={{-60,80},{-60,80},{-60,100.05},{-60.05,100.05}}, color={0,0,0}));
  connect(brake_2.flange_a, rotationalMultiSensor_2.flange_a)
    annotation (Line(points={{-60,50},{-60,55},{-60,60}}, color={0,0,0}));
  connect(brake_3.flange_a, rotationalMultiSensor_3.flange_a)
    annotation (Line(points={{60,-50},{60,-60}}, color={0,0,0}));
  connect(rotationalMultiSensor_3.flange_b, wheelHub_3.flange) annotation (Line(
        points={{60,-80},{60,-99.95},{59.95,-99.95}}, color={0,0,0}));
  connect(rotationalMultiSensor_4.flange_b, wheelHub_4.flange) annotation (Line(
        points={{60,80},{60,100.05},{59.95,100.05}}, color={0,0,0}));
  connect(brake_4.flange_a, rotationalMultiSensor_4.flange_a)
    annotation (Line(points={{60,50},{60,56},{60,60}},
                                               color={0,0,0}));
  connect(simpleController.brakesBus, brakesBus) annotation (Line(
      points={{-10,0},{-100,0}},
      color={255,204,51},
      thickness=0.5));
  connect(simpleController.fn_1, brake_1.f_normalized) annotation (Line(points=
          {{-6,-11},{-6,-11},{-6,-40},{-49,-40}}, color={0,0,127}));
  connect(simpleController.fn_2, brake_2.f_normalized)
    annotation (Line(points={{-6,11},{-6,40},{-49,40}}, color={0,0,127}));
  connect(simpleController.fn_3, brake_3.f_normalized)
    annotation (Line(points={{6,-11},{6,-40},{49,-40}}, color={0,0,127}));
  connect(simpleController.fn_4, brake_4.f_normalized)
    annotation (Line(points={{6,11},{6,11},{6,40},{49,40}}, color={0,0,127}));
  connect(rotationalMultiSensor_1.tau, brakesBus.tau_1) annotation (Line(points=
         {{-49,-66},{-40,-66},{-40,0},{-100.05,0},{-100.05,0.05}}, color={0,0,
          127}));
  connect(rotationalMultiSensor_2.tau, brakesBus.tau_2) annotation (Line(points=
         {{-49,66},{-40,66},{-40,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_3.tau, brakesBus.tau_3) annotation (Line(points=
         {{49,-66},{14,-66},{-20,-66},{-20,0.05},{-100.05,0.05}}, color={0,0,
          127}));
  connect(rotationalMultiSensor_4.tau, brakesBus.tau_4) annotation (Line(points=
         {{49,66},{-20,66},{-20,66},{-20,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_1.w, brakesBus.w_1) annotation (Line(points={{
          -49,-74.2},{-40,-74.2},{-40,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_2.w, brakesBus.w_2) annotation (Line(points={{
          -49,74.2},{-40,74.2},{-40,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_3.w, brakesBus.w_3) annotation (Line(points={{
          49,-74.2},{-20,-74.2},{-20,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_4.w, brakesBus.w_4) annotation (Line(points={{
          49,74.2},{-20,74.2},{-20,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_1.a, brakesBus.a_1) annotation (Line(points={{
          -49,-78},{-40,-78},{-40,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_2.a, brakesBus.a_2) annotation (Line(points={{
          -49,78},{-44,78},{-40,78},{-40,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_3.a, brakesBus.a_3) annotation (Line(points={{
          49,-78},{14,-78},{-20,-78},{-20,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_4.a, brakesBus.a_4) annotation (Line(points={{
          49,78},{-20,78},{-20,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(rotationalMultiSensor_1.power, multiSum.u[1]) annotation (Line(points={{-49,-62},
          {-4,-62},{40,-62},{40,3.15},{36,3.15}},           color={0,0,127}));
  connect(rotationalMultiSensor_2.power, multiSum.u[2]) annotation (Line(points={{-49,62},
          {40,62},{40,1.05},{36,1.05}},          color={0,0,127}));
  connect(rotationalMultiSensor_3.power, multiSum.u[3]) annotation (Line(points={{49,-62},
          {40,-62},{40,-1.05},{36,-1.05}},          color={0,0,127}));
  connect(rotationalMultiSensor_4.power, multiSum.u[4]) annotation (Line(points={{49,62},
          {40,62},{40,-3.15},{36,-3.15}},         color={0,0,127}));
  connect(multiSum.y, brakesBus.P) annotation (Line(points={{22.98,0},{20,0},{
          20,20},{-20,20},{-20,0.05},{-100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(heatPort, internalHeatPort)
    annotation (Line(points={{-100,-60},{-100,-20}}, color={191,0,0}));
  connect(internalHeatPort, fixedTemperature.port)
    annotation (Line(points={{-100,-20},{-90,-20},{-90,-24}}, color={191,0,0}));
  connect(internalHeatPort, prescribedHeatFlow.port)
    annotation (Line(points={{-100,-20},{-90,-20},{-80,-20}}, color={191,0,0}));
  connect(multiSum.y, gain.u) annotation (Line(points={{22.98,0},{20,0},{20,20},{
          -22.8,20}}, color={0,0,127}));
  connect(gain.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-36.6,20},
          {-50,20},{-50,-20},{-60,-20}}, color={0,0,127}));
  connect(gain.y, brakesBus.Losses) annotation (Line(points={{-36.6,20},{-50,20},
          {-50,0.05},{-100.05,0.05}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Brake system with four brakes at the four wheels. 
The brake signal [0..1] is distributed by the controller to all four brakes. 
The generated heat flow is dissipated either internally or to the optional heatport.
</p>
</html>"));
end Brakes4wheels;
