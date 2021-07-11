within EMOTH.Chassis;
model Dynamometer "Chassis dynamometer"
  import Modelica.Constants.g_n;
  extends VehicleInterfaces.Chassis.Interfaces.TwoAxleBase(final usingMultiBodyDriveline=false);
  extends VehicleInterfaces.Icons.Chassis;
  extends Modelica.Icons.UnderConstruction;
  parameter EMOTH.ParameterRecords.Vehicles.VehicleData vehicleData
    annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
  parameter EMOTH.ParameterRecords.Dynamometer.DynamometerData dynamometerData
    annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
  parameter Modelica.Units.SI.Force FRoll=dynamometerData.cr*vehicleData.m*g_n
    "Constant rolling reistance";
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
  Modelica.Mechanics.Translational.Sources.SignForce rollingResistance1(f_nominal=-FRoll/4,
    reg=Modelica.Blocks.Types.Regularization.Linear, final v0=1e-4*vehicleData.vNominal)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-18,-70})));
  Modelica.Mechanics.Translational.Sources.SignForce rollingResistance2(f_nominal=-FRoll/4,
    reg=Modelica.Blocks.Types.Regularization.Linear, final v0=1e-4*vehicleData.vNominal)
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-20,72})));
  Modelica.Mechanics.Translational.Sources.SignForce rollingResistance3(f_nominal=-FRoll/4,
    reg=Modelica.Blocks.Types.Regularization.Linear, final v0=1e-4*vehicleData.vNominal)
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={20,-70})));
  Modelica.Mechanics.Translational.Sources.SignForce rollingResistance4(f_nominal=-FRoll/4,
    reg=
    Modelica.Blocks.Types.Regularization.Linear, final v0=1e-4*vehicleData.vNominal)
    annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={20,70})));
  Modelica.Mechanics.Translational.Components.IdealRollingWheel roll_1(
    final radius=dynamometerData.rRoll)  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-40,-50})));
  Modelica.Mechanics.Translational.Components.IdealRollingWheel roll_2(
    final radius=dynamometerData.rRoll)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,50})));
  Modelica.Mechanics.Translational.Components.IdealRollingWheel roll_3(
    final radius=dynamometerData.rRoll)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-50})));
  Modelica.Mechanics.Translational.Components.IdealRollingWheel roll_4(
    final radius=dynamometerData.rRoll)  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={40,50})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaRoll_1(
    final J=dynamometerData.JRoll)  annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-40,-20})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaRoll_2(
    final J=dynamometerData.JRoll)  annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,20})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaRoll_3(
    final J=dynamometerData.JRoll)  annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={40,-20})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaRoll_4(
    final J=dynamometerData.JRoll)  annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,20})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft1
    annotation (Placement(transformation(extent={{150,-30},{170,-10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft2
    annotation (Placement(transformation(extent={{150,10},{170,30}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft3
    annotation (Placement(transformation(extent={{150,-70},{170,-50}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft4
    annotation (Placement(transformation(extent={{150,50},{170,70}})));
protected
  Interfaces.ChassisBus chassisBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-160,20})));
  Interfaces.DynamometerBus dynamometerBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-160,-40})));
equation
  connect(inertia_1.flange_b, wheel_1.flangeR)
    annotation (Line(points={{-70,-70},{-60,-70}},           color={0,0,0}));
  connect(inertia_1.flange_a, wheelHub_1.flange) annotation (Line(points={{-90,-70},
          {-90,-99.95},{-90.05,-99.95}}, color={0,0,0}));
  connect(inertia_2.flange_b, wheel_2.flangeR)
    annotation (Line(points={{-70,70},{-60,70}},          color={0,0,0}));
  connect(inertia_2.flange_a, wheelHub_2.flange) annotation (Line(points={{-90,70},
          {-90,100.05},{-90.05,100.05}}, color={0,0,0}));
  connect(inertia_3.flange_a, wheelHub_3.flange) annotation (Line(points={{90,-70},
          {90,-99.95},{89.95,-99.95}}, color={0,0,0}));
  connect(inertia_4.flange_b, wheel_4.flangeR)
    annotation (Line(points={{70,70},{60,70}},         color={0,0,0}));
  connect(inertia_4.flange_a, wheelHub_4.flange) annotation (Line(points={{90,70},
          {90,100.05},{89.95,100.05}}, color={0,0,0}));
  connect(controlBus.chassisBus, chassisBus) annotation (Line(
      points={{-158.1,60.1},{-160,60.1},{-160,20}},
      color={255,204,51},
      thickness=0.5));
  connect(wheel_3.flangeR, inertia_3.flange_b)
    annotation (Line(points={{60,-70},{70,-70}},          color={0,0,0}));
  connect(wheel_2.flangeT, rollingResistance2.flange)
    annotation (Line(points={{-40,70},{-40,72},{-30,72}},
                                                 color={0,127,0}));
  connect(wheel_4.flangeT, rollingResistance4.flange)
    annotation (Line(points={{40,70},{30,70}}, color={0,127,0}));
  connect(wheel_3.flangeT, rollingResistance3.flange)
    annotation (Line(points={{40,-70},{30,-70}}, color={0,127,0}));
  connect(wheel_1.flangeT, rollingResistance1.flange)
    annotation (Line(points={{-40,-70},{-28,-70}}, color={0,127,0}));
  connect(roll_1.flangeT, wheel_1.flangeT)
    annotation (Line(points={{-40,-60},{-40,-70}}, color={0,127,0}));
  connect(wheel_2.flangeT, roll_2.flangeT)
    annotation (Line(points={{-40,70},{-40,60}}, color={0,127,0}));
  connect(roll_3.flangeT, wheel_3.flangeT)
    annotation (Line(points={{40,-60},{40,-70}}, color={0,127,0}));
  connect(wheel_4.flangeT, roll_4.flangeT)
    annotation (Line(points={{40,70},{40,60}}, color={0,127,0}));
  connect(inertiaRoll_1.flange_b, roll_1.flangeR)
    annotation (Line(points={{-40,-30},{-40,-40}}, color={0,0,0}));
  connect(roll_2.flangeR, inertiaRoll_2.flange_b)
    annotation (Line(points={{-40,40},{-40,30}}, color={0,0,0}));
  connect(inertiaRoll_3.flange_b, roll_3.flangeR)
    annotation (Line(points={{40,-30},{40,-40}}, color={0,0,0}));
  connect(inertiaRoll_4.flange_b, roll_4.flangeR)
    annotation (Line(points={{40,30},{40,40}}, color={0,0,0}));
  connect(inertiaRoll_3.flange_a, shaft3) annotation (Line(points={{40,-10},{120,
          -10},{120,-60},{160,-60}}, color={0,0,0}));
  connect(inertiaRoll_1.flange_a, shaft1) annotation (Line(points={{-40,-10},{-40,
          -4},{140,-4},{140,-20},{160,-20}}, color={0,0,0}));
  connect(inertiaRoll_2.flange_a, shaft2) annotation (Line(points={{-40,10},{-40,
          4},{140,4},{140,20},{160,20}}, color={0,0,0}));
  connect(inertiaRoll_4.flange_a, shaft4) annotation (Line(points={{40,10},{120,
          10},{120,60},{160,60}}, color={0,0,0}));
  connect(dynamometerBus, controlBus.dynamometerBus) annotation (Line(
      points={{-160,-40},{-160,60},{-158,60}},
      color={255,204,51},
      thickness=0.5));
  annotation (Documentation(info="<html>
<p>
1-dimensioanl model of a chassis dynaometer, taking into account:
</p>
<ul>
<li>4 wheels with radius and inertia</li>
<li>constant rolling friction</li>
<li>4 rolls with radius and inertia</li>
</ul>
</html>"), Icon(graphics={
        Ellipse(
          extent={{60,-130},{120,-70}},
          lineColor={0,0,0},
          closure=EllipseClosure.Chord,
          startAngle=0,
          endAngle=180,
          fillColor={175,175,175},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{-128,70},{-68,50}},
          lineColor={0,0,0},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid),
        Line(points={{-108,54},{-108,50}}, color={0,0,0}),
        Line(points={{-88,54},{-88,50}}, color={0,0,0}),
        Line(points={{-124,52},{-124,50}}, color={0,0,0}),
        Line(points={{-120,52},{-120,50}}, color={0,0,0}),
        Line(points={{-112,52},{-112,50}}, color={0,0,0}),
        Line(points={{-116,52},{-116,50}}, color={0,0,0}),
        Line(points={{-92,52},{-92,50}}, color={0,0,0}),
        Line(points={{-96,52},{-96,50}}, color={0,0,0}),
        Line(points={{-104,52},{-104,50}}, color={0,0,0}),
        Line(points={{-100,52},{-100,50}}, color={0,0,0}),
        Line(points={{-72,52},{-72,50}}, color={0,0,0}),
        Line(points={{-76,52},{-76,50}}, color={0,0,0}),
        Line(points={{-84,52},{-84,50}}, color={0,0,0}),
        Line(points={{-80,52},{-80,50}}, color={0,0,0}),
        Line(points={{-104,70},{-104,62}}, color={0,0,0}),
        Polygon(
          points={{-106,62},{-102,62},{-104,56},{-106,62}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-134,-130},{-74,-70}},
          lineColor={0,0,0},
          closure=EllipseClosure.Chord,
          startAngle=0,
          endAngle=180,
          fillColor={175,175,175},
          fillPattern=FillPattern.Sphere)}));
end Dynamometer;
