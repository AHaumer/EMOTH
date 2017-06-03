within EMOTH.Drivers;
model DriverEnvironment "Interface to driver"
  extends VehicleInterfaces.DriverEnvironments.Interfaces.Base(
    final includeDriverSeat=false, final includeSteeringWheel=false,
    final includeAcceleratorPedal=false, final includeBrakePedal=false);
  extends VehicleInterfaces.Icons.DriverEnvironment;
  parameter Boolean useDriverModel "Use driver model (otherwise throttle and brake)?";
  parameter Boolean useRecuperation=true "Braking with recuperation, otherwise mechanical?";
  parameter Real SoCLo=0.980 "Recuperate below SoCLo, above use mechanical brake";
  Interfaces.DriverInterface driverInterface annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,0})));
  Components.RecuperationController recuperationController(final useRecuperation=useRecuperation, final
      SoCLo=SoCLo)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Logical.Hysteresis forwardDetection(
    final uLow=-0.1,
    final uHigh=0.1,
    final pre_y_start=true) if useDriverModel
    annotation (Placement(transformation(extent={{-60,20},{-80,40}})));
protected
  Interfaces.BatteryBus batteryBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-70})));
  Interfaces.BrakesBus brakesBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,30})));
  Interfaces.ChassisBus chassisBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,80})));
  Interfaces.ElectricMotorBus electricMotorBus annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-30})));
  Modelica.Blocks.Routing.RealPassThrough s
    annotation (Placement(transformation(extent={{6,84},{-6,96}})));
  Modelica.Blocks.Routing.RealPassThrough v
    annotation (Placement(transformation(extent={{-14,74},{-26,86}})));
  Modelica.Blocks.Routing.RealPassThrough a
    annotation (Placement(transformation(extent={{-34,64},{-46,76}})));
  Modelica.Blocks.Routing.RealPassThrough SoC annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={0,-50})));
  Modelica.Blocks.Routing.RealPassThrough vDC annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-20,-60})));
  Modelica.Blocks.Routing.RealPassThrough iDC annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-40,-70})));
  Modelica.Blocks.Routing.RealPassThrough pDC annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-60,-80})));
equation
  connect(v.y, driverInterface.v) annotation (Line(points={{-26.6,80},{-26.6,80},
          {-100.1,80},{-100.1,0.1}},
                             color={0,0,127}));
  connect(a.y, driverInterface.a) annotation (Line(points={{-46.6,70},{-46.6,70},
          {-100.1,70},{-100.1,0.1}},
                             color={0,0,127}));
  connect(a.u, chassisBus.a) annotation (Line(points={{-32.8,70},{-32.8,70},{50,
          70},{50,79.95},{60.05,79.95}},
                                      color={0,0,127}));
  connect(s.u, chassisBus.s) annotation (Line(points={{7.2,90},{7.2,90},{50,90},
          {50,79.95},{60.05,79.95}}, color={0,0,127}));
  connect(s.y, driverInterface.s) annotation (Line(points={{-6.6,90},{-6.6,90},{
          -100.1,90},{-100.1,0.1}},
                             color={0,0,127}));
  connect(v.u, chassisBus.v) annotation (Line(points={{-12.8,80},{60.05,80},{60.05,
          79.95}}, color={0,0,127}));
  connect(chassisBus, controlBus.chassisBus) annotation (Line(
      points={{60,80},{80,80},{80,59.9},{100.1,59.9}},
      color={255,204,51},
      thickness=0.5));
  connect(brakesBus, controlBus.brakesBus) annotation (Line(
      points={{60,30},{80,30},{80,59.9},{100.1,59.9}},
      color={255,204,51},
      thickness=0.5));
  connect(electricMotorBus, controlBus.electricMotorBus) annotation (Line(
      points={{60,-30},{70,-30},{80,-30},{80,59.9},{100.1,59.9}},
      color={255,204,51},
      thickness=0.5));
  connect(batteryBus, controlBus.batteryBus) annotation (Line(
      points={{60,-70},{80,-70},{80,59.9},{100.1,59.9}},
      color={255,204,51},
      thickness=0.5));
  connect(SoC.u, batteryBus.SoC) annotation (Line(points={{7.2,-50},{28,-50},{
          50,-50},{50,-70.05},{60.05,-70.05}}, color={0,0,127}));
  connect(SoC.y, driverInterface.SoC) annotation (Line(points={{-6.6,-50},{-54,
          -50},{-100.1,-50},{-100.1,0.1}}, color={0,0,127}));
  connect(vDC.u, batteryBus.vDC) annotation (Line(points={{-12.8,-60},{18,-60},
          {50,-60},{50,-70.05},{60.05,-70.05}}, color={0,0,127}));
  connect(iDC.u, batteryBus.iDC) annotation (Line(points={{-32.8,-70},{60.05,
          -70},{60.05,-70.05}}, color={0,0,127}));
  connect(pDC.u, batteryBus.PDC) annotation (Line(points={{-52.8,-80},{-2,-80},
          {50,-80},{50,-70.05},{60.05,-70.05}}, color={0,0,127}));
  connect(vDC.y, driverInterface.vDC) annotation (Line(points={{-26.6,-60},{-64,
          -60},{-100.1,-60},{-100.1,0.1}}, color={0,0,127}));
  connect(iDC.y, driverInterface.iDC) annotation (Line(points={{-46.6,-70},{
          -100.1,-70},{-100.1,0.1}}, color={0,0,127}));
  connect(pDC.y, driverInterface.pDC) annotation (Line(points={{-66.6,-80},{-84,
          -80},{-100.1,-80},{-100.1,0.1}}, color={0,0,127}));
  connect(forwardDetection.u, driverInterface.vPreview) annotation (Line(points=
         {{-58,30},{-40,30},{-40,0},{-100.1,0},{-100.1,0.1}}, color={0,0,127}));
  connect(forwardDetection.y, driverInterface.forward) annotation (Line(points={
          {-81,30},{-90,30},{-100.1,30},{-100.1,0.1}}, color={255,0,255}));
  connect(recuperationController.driverInterface, driverInterface) annotation (
      Line(
      points={{-10,0},{-100,0}},
      color={85,85,255},
      thickness=0.5));
  connect(recuperationController.fn_brake, brakesBus.fn_brake) annotation (Line(
        points={{11,6},{20,6},{20,29.95},{60.05,29.95}}, color={0,0,127}));
  connect(recuperationController.throttle, electricMotorBus.throttle)
    annotation (Line(points={{11,-6},{20,-6},{20,-30.05},{60.05,-30.05}}, color=
         {0,0,127}));
  annotation (Documentation(info="<html>
<p>
The driver environment communicates measured values from the sub-busses of the <a href=\"modelica://VehicleInterfaces.Interfaces.ControlBus\">control bus</a> 
to the <a href=\"modelica://EMOTH.Interfaces.DriverInterface\">driver interface</a>, 
and the driver commands back from the driver interface to the sub-busses of the control bus.
</p>
<p>
<b>Take care</b>:<br>
If used with a <a href=\"modelica://EMOTH.Drivers.ThrottleAndBrake\">throttle and brake model</a>, you have to set useDriverModel = false. 
The throttle and brake model defines the direction of movement (forward/backward).<br>
If used with a <a href=\"modelica://EMOTH.Drivers.Driver\">driver model</a>, you have to set useDriverModel = true. 
The direction of movement (forward/backward) is automatically detected from the bus signal vPreview.
</p>
<p>
The throttle and brake signals are sent to the brake system and the electric drive, depending on the the replaceable 
<a href=\"modelica://EMOTH.Drivers.Components.BaseRecuperationController\">recuperation controller</a>.
</p>
</html>"), Icon(graphics={
        Polygon(visible=not useDriverModel,
          points={{-50,76},{-40,76},{-38,80},{-8,84},{0,88},{0,90},{-8,86},{-42,
              84},{-50,76}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(visible=not useDriverModel,
          extent={{-50,76},{-40,44}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(visible=not useDriverModel,
          extent={{-40,70},{0,50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder)}));
end DriverEnvironment;
