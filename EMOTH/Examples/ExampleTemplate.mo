within EMOTH.Examples;
partial model ExampleTemplate "Template for examples"
  extends EMOTH.Icons.ExampleTemplate;
  replaceable parameter EMOTH.ParameterRecords.Vehicles.VehicleTestData vehicleData
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  Chassis.Car2Axle chassis(
    vehicleData=vehicleData,
    a(start=0),
    s(start=0, fixed=true),
    v(start=0, fixed=true))
    annotation (Placement(transformation(extent={{60,-10},{92,10}})));
  Brakes.Brakes4wheels brakes4wheels(vehicleData = vehicleData, includeHeatPort = false) annotation (
    Placement(transformation(extent={{20,-10},{40,10}})));
  DriveLines.RearAxleDrive rearAxleDrive(vehicleData = vehicleData, includeHeatPort = false) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Tracks.Track track  annotation (
    Placement(transformation(extent = {{60, 40}, {40, 60}})));
  replaceable parameter EMOTH.ParameterRecords.ElectricDrives.GenericDrives.DriveTestData driveData
    annotation (
    Placement(transformation(extent={{-40,-50},{-20,-30}})));
  EMOTH.ElectricDrives.GenericDrive genericDrive(driveData=driveData, includeHeatPort=false)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  replaceable parameter EMOTH.ParameterRecords.EnergyStorages.BatteryTestData batteryData
    annotation (
    Placement(transformation(extent={{-80,-50},{-60,-30}})));
  EnergyStorages.SimpleBattery battery(batteryData = batteryData, includeHeatPort = false, SoC0=1.0)
    annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-70, 0})));
  Drivers.DriverEnvironment driverEnvironment
    annotation (
    Placement(transformation(extent={{0,40},{20,60}})));
equation
  connect(chassis.wheelHub_2, brakes4wheels.wheelHub_2) annotation (Line(
      points={{67,10},{67,18},{24,18},{24,10}},
      color={135,135,135},
      thickness=0.5));
  connect(chassis.wheelHub_4, brakes4wheels.wheelHub_4) annotation (Line(
      points={{85,10},{85,22},{36,22},{36,10}},
      color={135,135,135},
      thickness=0.5));
  connect(brakes4wheels.wheelHub_3, chassis.wheelHub_3) annotation (Line(
      points={{36,-10},{36,-22},{85,-22},{85,-10}},
      color={135,135,135},
      thickness=0.5));
  connect(brakes4wheels.wheelHub_1, chassis.wheelHub_1) annotation (Line(
      points={{24,-10},{24,-18},{67,-18},{67,-10}},
      color={135,135,135},
      thickness=0.5));
  connect(brakes4wheels.wheelHub_2, rearAxleDrive.wheelHub_2) annotation (
    Line(points={{24,10},{24,18},{-6,18},{-6,10}},                    color = {135, 135, 135}, thickness = 0.5));
  connect(brakes4wheels.wheelHub_4, rearAxleDrive.wheelHub_4) annotation (
    Line(points={{36,10},{36,22},{6,22},{6,10}},          color = {135, 135, 135}, thickness = 0.5));
  connect(brakes4wheels.wheelHub_1, rearAxleDrive.wheelHub_1) annotation (
    Line(points={{24,-10},{24,-18},{-6,-18},{-6,-10}},          color = {135, 135, 135}, thickness = 0.5));
  connect(brakes4wheels.wheelHub_3, rearAxleDrive.wheelHub_3) annotation (
    Line(points={{36,-10},{36,-22},{6,-22},{6,-10}},                     color = {135, 135, 135}, thickness = 0.5));
  connect(genericDrive.shaft_b, rearAxleDrive.transmissionFlange) annotation (
      Line(
      points={{-20,0},{-20,0},{-10,0}},
      color={135,135,135},
      thickness=0.5));
  connect(battery.pin_p, genericDrive.pin_p) annotation (Line(points={{-64,10},{
          -64,10},{-64,22},{-24,22},{-24,10}}, color={0,0,255}));
  connect(battery.pin_n, genericDrive.pin_n) annotation (Line(points={{-76,10},{
          -76,10},{-76,18},{-36,18},{-36,10}}, color={0,0,255}));
  connect(rearAxleDrive.controlBus, genericDrive.controlBus) annotation (Line(
      points={{-10,6},{-14,6},{-14,30},{-44,30},{-44,-6},{-40,-6}},
      color={255,204,51},
      thickness=0.5));
  connect(rearAxleDrive.controlBus, battery.controlBus) annotation (
    Line(points={{-10,6},{-14,6},{-14,30},{-84,30},{-84,-6},{-80,-6}},              color = {255, 204, 51}, thickness = 0.5));
  connect(track.controlBus, driverEnvironment.controlBus) annotation (
    Line(points={{40,56},{20,56}},                color = {255, 204, 51}, thickness = 0.5));
  connect(rearAxleDrive.controlBus, track.controlBus) annotation (Line(
      points={{-10,6},{-14,6},{-14,30},{30,30},{30,56},{40,56}},
      color={255,204,51},
      thickness=0.5));
  connect(rearAxleDrive.controlBus, brakes4wheels.controlBus) annotation (Line(
      points={{-10,6},{-14,6},{-14,30},{16,30},{16,6},{20,6}},
      color={255,204,51},
      thickness=0.5));
  connect(brakes4wheels.controlBus, chassis.controlBus) annotation (Line(
      points={{20,6},{16,6},{16,30},{56,30},{56,6},{60.2,6}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    experiment(
      StopTime=86400,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>
Example template for a full electric vehicle. 
</p>
<h4>Note:</h4>
<p>
Checking this example template you get a warning / error message. You have to connect an appropriate model to the <code>driverEnvironment.driverInterface</code>:
</p>
<ul>
<li><a href=\"modelica://EMOTH.Drivers.ThrottleAndBrake\">throttleAndBrake</a></li>
<li><a href=\"modelica://EMOTH.Drivers.Driver\">driver</a></li>
<li><a href=\"modelica://EMOTH.Drivers.CruiseControl\">cruiseControl</a></li>
</ul>
<p>
Don't forget to set:
</p>
<ul>
<li><code>driverEnvironment.useDriverModel</code></li>
<li><code>driverEnvironment.useRecuperation</code></li>
<li><code>track.inclinationData</code></li>
<li><code>track.rollingResistanceData</code></li>
<li><code>chassis.v.start</code>; using a <a href=\"modelica://EMOTH.Drivers.DrivingCycle\">driving cycle</a>, you may set <code>chassis.v.start=drivingCycle.v0</code></li>
</ul>
<p>
You may want to add:
</p>
<ul>
<li>an <a href=\"modelica://EMOTH.Accessories.ElectricalAccessories\">electricalAccesories</a> model</li>
<li>a <a href=\"modelica://EMOTH.Accessories.RangeExtender\">rangeExtender</a></li>
</ul>
</html>"));
end ExampleTemplate;
