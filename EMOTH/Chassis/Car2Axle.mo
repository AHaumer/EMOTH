within EMOTH.Chassis;
model Car2Axle "Car chassis with 2 axles"
  extends VehicleInterfaces.Chassis.Interfaces.TwoAxleBase(final usingMultiBodyDriveline=false);
  extends VehicleInterfaces.Icons.Chassis;
  parameter EMOTH.ParameterRecords.Vehicles.VehicleData vehicleData
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  output Modelica.Units.SI.Position s(start=0) = mass.s "Vehicle position";
  output Modelica.Units.SI.Velocity v(
    start=0,
    displayUnit="km/h") = mass.v "Vehicle velocity";
  output Modelica.Units.SI.Acceleration a(start=0) = mass.a
    "Vehicle acceleration";
  Modelica.Mechanics.Translational.Components.Mass mass(final m=vehicleData.m)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Translational.Components.IdealRollingWheel wheel_1(final
      radius=vehicleData.rFront)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,-70})));
  Modelica.Mechanics.Translational.Components.IdealRollingWheel wheel_2(final
      radius=vehicleData.rFront)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-50,70})));
  Modelica.Mechanics.Translational.Components.IdealRollingWheel wheel_3(final
      radius=vehicleData.rRear)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,-70})));
  Modelica.Mechanics.Translational.Components.IdealRollingWheel wheel_4(final
      radius=vehicleData.rRear)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={50,70})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia_1(final J=
        vehicleData.JFront)                                  annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,-70})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia_2(final J=
        vehicleData.JFront)                                  annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-80,70})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia_3(final J=
        vehicleData.JRear)                                   annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,-70})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia_4(final J=
        vehicleData.JRear)                                   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={80,70})));
  EMOTH.Sensors.TranslationalMultiSensor translationalMultiSensor
    annotation (Placement(transformation(extent={{-40,10},{-60,-10}})));
  EMOTH.Chassis.Components.DragResistance
    dragResistance(
    final f_nominal=-vehicleData.Fdrag,
    final v_nominal=vehicleData.vNominal)
                                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-20})));
  Components.RollingResistance rollingResistance1(final m=vehicleData.m/4,
      final v0=1e-4*vehicleData.vNominal) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-60})));
  Components.InclinationResistance inclinationResistance(final m=vehicleData.m)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Continuous.Integrator integratorEnergy(final k=1)
    annotation (Placement(transformation(extent={{-120,40},{-140,60}})));
  EMOTH.Chassis.Components.RollingResistance rollingResistance2(final m=
        vehicleData.m/4, final v0=1e-4*vehicleData.vNominal) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-30,60})));
  EMOTH.Chassis.Components.RollingResistance rollingResistance3(final m=
        vehicleData.m/4, final v0=1e-4*vehicleData.vNominal) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={30,-60})));
  EMOTH.Chassis.Components.RollingResistance rollingResistance4(final m=
        vehicleData.m/4, final v0=1e-4*vehicleData.vNominal) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,60})));
protected
  Interfaces.ChassisBus chassisBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-160,0})));
equation
  connect(inertia_1.flange_b, wheel_1.flangeR)
    annotation (Line(points={{-70,-70},{-70,-70},{-60,-70}}, color={0,0,0}));
  connect(inertia_1.flange_a, wheelHub_1.flange) annotation (Line(points={{-90,-70},
          {-90,-99.95},{-90.05,-99.95}}, color={0,0,0}));
  connect(inertia_2.flange_b, wheel_2.flangeR)
    annotation (Line(points={{-70,70},{-70,70},{-60,70}}, color={0,0,0}));
  connect(inertia_2.flange_a, wheelHub_2.flange) annotation (Line(points={{-90,70},
          {-90,100.05},{-90.05,100.05}}, color={0,0,0}));
  connect(inertia_3.flange_a, wheelHub_3.flange) annotation (Line(points={{90,-70},
          {90,-99.95},{89.95,-99.95}}, color={0,0,0}));
  connect(inertia_4.flange_b, wheel_4.flangeR)
    annotation (Line(points={{70,70},{60,70}},         color={0,0,0}));
  connect(inertia_4.flange_a, wheelHub_4.flange) annotation (Line(points={{90,70},
          {90,100.05},{89.95,100.05}}, color={0,0,0}));
  connect(controlBus.chassisBus, chassisBus) annotation (Line(
      points={{-158.1,60.1},{-160,60.1},{-160,0}},
      color={255,204,51},
      thickness=0.5));
  connect(inclinationResistance.inclination, chassisBus.inclination)
    annotation (Line(points={{-102,20},{-110,20},{-110,0.05},{-160.05,0.05}},
        color={0,0,127}));
  connect(translationalMultiSensor.s, chassisBus.s) annotation (Line(points={{-50,11},
          {-50,40},{-110,40},{-110,0.05},{-160.05,0.05}},
        color={0,0,127}));
  connect(translationalMultiSensor.v, chassisBus.v) annotation (Line(points={{-54.2,
          11},{-54.2,40},{-110,40},{-110,0.05},{-160.05,0.05}},       color={0,
          0,127}));
  connect(translationalMultiSensor.a, chassisBus.a) annotation (Line(points={{-58,11},
          {-58,40},{-110,40},{-110,0.05},{-160.05,0.05}},         color={0,0,
          127}));
  connect(translationalMultiSensor.f, chassisBus.f) annotation (Line(points={{-46,11},
          {-46,40},{-110,40},{-110,0.05},{-160.05,0.05}},         color={0,0,
          127}));
  connect(wheel_3.flangeR, inertia_3.flange_b)
    annotation (Line(points={{60,-70},{65,-70},{70,-70}}, color={0,0,0}));
  connect(translationalMultiSensor.power, chassisBus.P) annotation (Line(points={{-42,11},
          {-42,40},{-110,40},{-110,0.05},{-160.05,0.05}},
        color={0,0,127}));
  connect(mass.flange_a, translationalMultiSensor.flange_a)
    annotation (Line(points={{-10,0},{-40,0}},         color={0,127,0}));
  connect(translationalMultiSensor.flange_b, inclinationResistance.flange)
    annotation (Line(points={{-60,0},{-70,0},{-70,20},{-80,20}}, color={0,127,0}));
  connect(translationalMultiSensor.flange_b, dragResistance.flange) annotation (
     Line(points={{-60,0},{-70,0},{-70,-20},{-80,-20}},         color={0,127,0}));
  connect(translationalMultiSensor.power, integratorEnergy.u) annotation (Line(
        points={{-42,11},{-42,50},{-118,50}},          color={0,0,127}));
  connect(integratorEnergy.y, chassisBus.E) annotation (Line(points={{-141,50},{-150,
          50},{-150,0.05},{-160.05,0.05}}, color={0,0,127}));
  connect(dragResistance.vWind, chassisBus.vWind) annotation (Line(points={{-102,
          -20},{-110,-20},{-110,0.05},{-160.05,0.05}}, color={0,0,127}));
  connect(wheel_2.flangeT, rollingResistance2.flange)
    annotation (Line(points={{-40,70},{-30,70}}, color={0,127,0}));
  connect(rollingResistance2.flange, mass.flange_a)
    annotation (Line(points={{-30,70},{-10,70},{-10,0}}, color={0,127,0}));
  connect(wheel_4.flangeT, rollingResistance4.flange)
    annotation (Line(points={{40,70},{30,70}}, color={0,127,0}));
  connect(rollingResistance4.flange, mass.flange_b)
    annotation (Line(points={{30,70},{10,70},{10,0}}, color={0,127,0}));
  connect(wheel_3.flangeT, rollingResistance3.flange)
    annotation (Line(points={{40,-70},{30,-70}}, color={0,127,0}));
  connect(rollingResistance3.flange, mass.flange_b)
    annotation (Line(points={{30,-70},{10,-70},{10,0}}, color={0,127,0}));
  connect(rollingResistance1.flange, mass.flange_a)
    annotation (Line(points={{-30,-70},{-10,-70},{-10,0}}, color={0,127,0}));
  connect(wheel_1.flangeT, rollingResistance1.flange)
    annotation (Line(points={{-40,-70},{-30,-70}}, color={0,127,0}));
  connect(rollingResistance1.rollingResistance, chassisBus.cr) annotation (Line(
        points={{-36,-48},{-36,-40},{-110,-40},{-110,0.05},{-160.05,0.05}},
        color={0,0,127}));
  connect(rollingResistance3.rollingResistance, chassisBus.cr) annotation (Line(
        points={{36,-48},{36,-40},{-110,-40},{-110,0.05},{-160.05,0.05}}, color=
         {0,0,127}));
  connect(rollingResistance2.rollingResistance, chassisBus.cr) annotation (Line(
        points={{-36,48},{-36,40},{-110,40},{-110,0.05},{-160.05,0.05}}, color=
          {0,0,127}));
  connect(rollingResistance4.rollingResistance, chassisBus.cr) annotation (Line(
        points={{36,48},{36,40},{-110,40},{-110,0.05},{-160.05,0.05}}, color={0,
          0,127}));
  connect(rollingResistance4.inclination, chassisBus.inclination) annotation (
      Line(points={{30,48},{30,40},{-110,40},{-110,0.05},{-160.05,0.05}}, color=
         {0,0,127}));
  connect(rollingResistance2.inclination, chassisBus.inclination) annotation (
      Line(points={{-30,48},{-30,40},{-110,40},{-110,0.05},{-160.05,0.05}},
        color={0,0,127}));
  connect(rollingResistance3.inclination, chassisBus.inclination) annotation (
      Line(points={{30,-48},{30,-40},{-110,-40},{-110,0.05},{-160.05,0.05}},
        color={0,0,127}));
  connect(rollingResistance1.inclination, chassisBus.inclination) annotation (
      Line(points={{-30,-48},{-30,-40},{-110,-40},{-110,0.05},{-160.05,0.05}},
        color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Simple 1-dimensioanl chassis model, taking into account:
</p>
<ul>
<li>Longitudional dynamic behaviour of the vehicle mass along the track</li>
<li>Driving resistances: inclination, rolling and drag (taking wind speed into account)</li>
<li>4 wheels with inertias</li>
</ul>
<p>
Losses due to drag and rolling resistance are only dissipated internally, since they would not be taken into account in a thermal management system.
</p>
</html>"));
end Car2Axle;
