within EMOTH.Examples;
model TestWithDriver "Test with driver over a driving cycle"
  import EMOTH;
  extends Modelica.Icons.Example;
  parameter EMOTH.ParameterRecords.Vehicles.VehicleTestData vehicleData annotation (
    Placement(transformation(extent = {{30, -50}, {50, -30}})));
  Chassis.Car2Axle car2Axle(a(start = 0), s(start = 0, fixed = true), vehicleData = vehicleData, v(start = 0, fixed = true)) annotation (
    Placement(transformation(extent = {{24, -10}, {56, 10}})));
  Brakes.Brakes4wheels brakes4wheels(vehicleData = vehicleData, includeHeatPort = false) annotation (
    Placement(transformation(extent = {{70, -10}, {90, 10}})));
  DriveLines.RearAxleDrive rearAxleDrive(vehicleData = vehicleData, includeHeatPort = false) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  parameter EMOTH.ParameterRecords.SingleTrackData inclinationData "Definition of inclination versus position on track" annotation (
    Placement(transformation(extent = {{20, 70}, {40, 90}})));
  parameter EMOTH.ParameterRecords.SingleTrackData rollingResistanceData(ConstantValue = 0.02) "Definition of cR versus position on track" annotation (
    Placement(transformation(extent = {{60, 70}, {80, 90}})));
  Tracks.Track track(inclinationData = inclinationData, rollingResistanceData = rollingResistanceData) annotation (
    Placement(transformation(extent = {{60, 40}, {40, 60}})));
  parameter EMOTH.ParameterRecords.ElectricDrives.GenericDrives.DriveTestData driveData annotation (
    Placement(transformation(extent = {{-40, -50}, {-20, -30}})));
  ElectricDrives.GenericDrive genericDrive(driveData = driveData, includeHeatPort = false) annotation (
    Placement(transformation(extent = {{-40, -10}, {-20, 10}})));
  parameter EMOTH.ParameterRecords.EnergyStorages.BatteryTestData batteryData annotation (
    Placement(transformation(extent = {{-80, -50}, {-60, -30}})));
  EnergyStorages.SimpleBattery battery(batteryData = batteryData, includeHeatPort = false) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-70, 0})));
  Drivers.DriverEnvironment driverEnvironment(useDriverModel = true) annotation (
    Placement(transformation(extent = {{0, 40}, {20, 60}})));
  Drivers.Driver driver annotation (
    Placement(transformation(extent = {{-40, 40}, {-20, 60}})));
  Drivers.DrivingCycle drivingCycle(                                                                                                                           table = [0, 0; 5, 50; 20, 50; 25, 0; 40, 0; 50, 100; 170, 100; 180, 50; 210, 50; 220, 0; 240, 0],
    cycle=EMOTH.Drivers.Components.CycleType.NEDC,
    n=-1,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)                                                                                                                                                                                            annotation (
    Placement(transformation(extent = {{-40, 70}, {-20, 90}})));
  EMOTH.Accessories.ElectricalAccessories electricalAccessories(P = 5000) annotation (
    Placement(transformation(extent = {{-60, -90}, {-40, -70}})));
  EMOTH.Accessories.RangeExtender rangeExtender(P = 6000) annotation (
    Placement(transformation(extent = {{-20, -90}, {0, -70}})));
equation
  connect(car2Axle.wheelHub_2, brakes4wheels.wheelHub_2) annotation (
    Line(points = {{31, 10}, {31, 18}, {74, 18}, {74, 10}}, color = {135, 135, 135}, thickness = 0.5));
  connect(car2Axle.wheelHub_4, brakes4wheels.wheelHub_4) annotation (
    Line(points = {{49, 10}, {49, 22}, {86, 22}, {86, 10}}, color = {135, 135, 135}, thickness = 0.5));
  connect(brakes4wheels.wheelHub_3, car2Axle.wheelHub_3) annotation (
    Line(points = {{86, -10}, {86, -22}, {49, -22}, {49, -10}}, color = {135, 135, 135}, thickness = 0.5));
  connect(brakes4wheels.wheelHub_1, car2Axle.wheelHub_1) annotation (
    Line(points = {{74, -10}, {74, -10}, {74, -18}, {31, -18}, {31, -10}}, color = {135, 135, 135}, thickness = 0.5));
  connect(car2Axle.controlBus, brakes4wheels.controlBus) annotation (
    Line(points = {{24.2, 6}, {20, 6}, {20, 30}, {66, 30}, {66, 6}, {70, 6}}, color = {255, 204, 51}, thickness = 0.5));
  connect(brakes4wheels.wheelHub_2, rearAxleDrive.wheelHub_2) annotation (
    Line(points = {{74, 10}, {74, 10}, {74, 18}, {-6, 18}, {-6, 10}}, color = {135, 135, 135}, thickness = 0.5));
  connect(brakes4wheels.wheelHub_4, rearAxleDrive.wheelHub_4) annotation (
    Line(points = {{86, 10}, {86, 22}, {6, 22}, {6, 10}}, color = {135, 135, 135}, thickness = 0.5));
  connect(brakes4wheels.wheelHub_1, rearAxleDrive.wheelHub_1) annotation (
    Line(points = {{74, -10}, {74, -18}, {-6, -18}, {-6, -10}}, color = {135, 135, 135}, thickness = 0.5));
  connect(brakes4wheels.wheelHub_3, rearAxleDrive.wheelHub_3) annotation (
    Line(points = {{86, -10}, {86, -10}, {86, -22}, {6, -22}, {6, -10}}, color = {135, 135, 135}, thickness = 0.5));
  connect(car2Axle.controlBus, rearAxleDrive.controlBus) annotation (
    Line(points = {{24.2, 6}, {20, 6}, {20, 30}, {-14, 30}, {-14, 6}, {-10, 6}}, color = {255, 204, 51}, thickness = 0.5));
  connect(brakes4wheels.controlBus, track.controlBus) annotation (
    Line(points = {{70, 6}, {66, 6}, {66, 30}, {30, 30}, {30, 56}, {40, 56}}, color = {255, 204, 51}, thickness = 0.5));
  connect(genericDrive.shaft_b, rearAxleDrive.transmissionFlange) annotation (
    Line(points = {{-20, 0}, {-20, 0}, {-10, 0}}, color = {135, 135, 135}, thickness = 0.5));
  connect(battery.pin_p, genericDrive.pin_p) annotation (
    Line(points = {{-64, 10}, {-64, 10}, {-64, 22}, {-24, 22}, {-24, 10}}, color = {0, 0, 255}));
  connect(battery.pin_n, genericDrive.pin_n) annotation (
    Line(points = {{-76, 10}, {-76, 10}, {-76, 18}, {-36, 18}, {-36, 10}}, color = {0, 0, 255}));
  connect(rearAxleDrive.controlBus, genericDrive.controlBus) annotation (
    Line(points = {{-10, 6}, {-14, 6}, {-14, 30}, {-44, 30}, {-44, -6}, {-40, -6}}, color = {255, 204, 51}, thickness = 0.5));
  connect(rearAxleDrive.controlBus, battery.controlBus) annotation (
    Line(points = {{-10, 6}, {-14, 6}, {-14, 30}, {-86, 30}, {-86, -6}, {-80, -6}}, color = {255, 204, 51}, thickness = 0.5));
  connect(track.controlBus, driverEnvironment.controlBus) annotation (
    Line(points = {{40, 56}, {40, 56}, {20, 56}}, color = {255, 204, 51}, thickness = 0.5));
  connect(driver.driverInterface, driverEnvironment.driverInterface) annotation (
    Line(points = {{-20, 50}, {-20, 50}, {0, 50}}, color = {85, 85, 255}, thickness = 0.5));
  connect(driver.driverInterface, drivingCycle.driverInterface) annotation (
    Line(points = {{-20, 50}, {-10, 50}, {-10, 78}, {-10, 80}, {-20, 80}}, color = {85, 85, 255}, thickness = 0.5));
  connect(battery.pin_n, electricalAccessories.pin_n) annotation (
    Line(points = {{-76, 10}, {-76, 18}, {-56, 18}, {-56, -70}}, color = {0, 0, 255}));
  connect(battery.pin_p, electricalAccessories.pin_p) annotation (
    Line(points = {{-64, 10}, {-64, 22}, {-52, 22}, {-52, -58}, {-44, -58}, {-44, -70}}, color = {0, 0, 255}));
  connect(battery.pin_n, rangeExtender.pin_n) annotation (
    Line(points = {{-76, 10}, {-76, 18}, {-56, 18}, {-56, -62}, {-16, -62}, {-16, -70}}, color = {0, 0, 255}));
  connect(battery.pin_p, rangeExtender.pin_p) annotation (
    Line(points = {{-64, 10}, {-64, 10}, {-64, 22}, {-52, 22}, {-52, -58}, {-4, -58}, {-4, -70}}, color = {0, 0, 255}));
  connect(battery.controlBus, electricalAccessories.controlBus) annotation (
    Line(points = {{-80, -6}, {-86, -6}, {-86, -86}, {-60, -86}}, color = {255, 204, 51}, thickness = 0.5));
  connect(electricalAccessories.controlBus, rangeExtender.controlBus) annotation (
    Line(points = {{-60, -86}, {-86, -86}, {-86, -94}, {-24, -94}, {-24, -86}, {-20, -86}}, color = {255, 204, 51}, thickness = 0.5));
  annotation (
    experiment(StopTime = 86400, Interval = 0.1),
    Documentation(info = "<html>
<p>
A full electric vehicle is driven along a track by a <a href=\"modelica://EMOTH.Drivers.Driver\">driver</a> model, 
following the <a href=\"modelica://EMOTH.Drivers.DrivingCycle\">driving cycle</a>. 
The driving cycle is repeated periodically. 
Simulation Stop time is set to 86400 s, simulation stops after n = 1 cycles.
</p>
</html>"));
end TestWithDriver;
