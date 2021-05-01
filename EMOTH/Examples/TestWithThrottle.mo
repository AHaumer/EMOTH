within EMOTH.Examples;
model TestWithThrottle "Test with external throttle and brake"
  import EMOTH;
  extends Modelica.Icons.Example;
  parameter EMOTH.ParameterRecords.Vehicles.VehicleTestData vehicleData
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  Chassis.Car2Axle car2Axle(
    a(start=0),
    s(start=0, fixed=true),
    vehicleData=vehicleData,
    v(start=0, fixed=true))
    annotation (Placement(transformation(extent={{24,-10},{56,10}})));
  Brakes.Brakes4wheels brakes4wheels(vehicleData=vehicleData, includeHeatPort=true)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  DriveLines.RearAxleDrive rearAxleDrive(vehicleData=vehicleData, includeHeatPort=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  parameter EMOTH.ParameterRecords.SingleTrackData inclinationData(
    useConstant=false,
    table=[0,0; 200,0; 200.1,0.1; 299.9,0.1; 300,0; 1300,0; 1300.1,-0.1; 1399.9,-0.1; 1400,0; 1600,0],
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Definition of inclination versus position on track"
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  parameter EMOTH.ParameterRecords.SingleTrackData rollingResistanceData(
      ConstantValue=0.02) "Definition of cR versus position on track"
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  Tracks.Track track(inclinationData=inclinationData,
    rollingResistanceData=rollingResistanceData)
    annotation (Placement(transformation(extent={{60,40},{40,60}})));
  parameter EMOTH.ParameterRecords.ElectricDrives.GenericDrives.DriveTestData driveData
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  ElectricDrives.GenericDrive genericDrive(driveData=driveData, includeHeatPort=true)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  parameter EMOTH.ParameterRecords.EnergyStorages.BatteryTestData batteryData
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  EnergyStorages.SimpleBattery battery(includeHeatPort=true, batteryData=batteryData) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,0})));
  Drivers.DriverEnvironment driverEnvironment(useDriverModel=false, useRecuperation=false)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Drivers.ThrottleAndBrake throttleAndBrake(ConstantBrake=false, ConstantThrottle=false)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.CombiTimeTable cycle(
    table=[0,0,0; 0,1,0; 5,1,0; 5,1,0; 10,1,0; 10,0.25,0; 45,0.25,0; 45,0,1; 55,0,1; 55,0,0; 60,0,0],
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambient(T=293.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={78,-40})));
equation
  connect(car2Axle.wheelHub_2, brakes4wheels.wheelHub_2) annotation (Line(
      points={{31,10},{31,18},{74,18},{74,10}},
      color={135,135,135},
      thickness=0.5));
  connect(car2Axle.wheelHub_4, brakes4wheels.wheelHub_4) annotation (Line(
      points={{49,10},{49,22},{86,22},{86,10}},
      color={135,135,135},
      thickness=0.5));
  connect(brakes4wheels.wheelHub_3, car2Axle.wheelHub_3) annotation (Line(
      points={{86,-10},{86,-22},{49,-22},{49,-10}},
      color={135,135,135},
      thickness=0.5));
  connect(brakes4wheels.wheelHub_1, car2Axle.wheelHub_1) annotation (Line(
      points={{74,-10},{74,-10},{74,-18},{31,-18},{31,-10}},
      color={135,135,135},
      thickness=0.5));
  connect(car2Axle.controlBus, brakes4wheels.controlBus) annotation (Line(
      points={{24.2,6},{20,6},{20,30},{66,30},{66,6},{70,6}},
      color={255,204,51},
      thickness=0.5));
  connect(brakes4wheels.wheelHub_2, rearAxleDrive.wheelHub_2) annotation (Line(
      points={{74,10},{74,10},{74,18},{-6,18},{-6,10}},
      color={135,135,135},
      thickness=0.5));
  connect(brakes4wheels.wheelHub_4, rearAxleDrive.wheelHub_4) annotation (Line(
      points={{86,10},{86,22},{6,22},{6,10}},
      color={135,135,135},
      thickness=0.5));
  connect(brakes4wheels.wheelHub_1, rearAxleDrive.wheelHub_1) annotation (Line(
      points={{74,-10},{74,-18},{-6,-18},{-6,-10}},
      color={135,135,135},
      thickness=0.5));
  connect(brakes4wheels.wheelHub_3, rearAxleDrive.wheelHub_3) annotation (Line(
      points={{86,-10},{86,-10},{86,-22},{6,-22},{6,-10}},
      color={135,135,135},
      thickness=0.5));
  connect(car2Axle.controlBus, rearAxleDrive.controlBus) annotation (Line(
      points={{24.2,6},{20,6},{20,30},{-14,30},{-14,6},{-10,6}},
      color={255,204,51},
      thickness=0.5));
  connect(brakes4wheels.controlBus, track.controlBus) annotation (Line(
      points={{70,6},{66,6},{66,30},{30,30},{30,56},{40,56}},
      color={255,204,51},
      thickness=0.5));
  connect(genericDrive.shaft_b, rearAxleDrive.transmissionFlange) annotation (
      Line(
      points={{-20,0},{-20,0},{-10,0}},
      color={135,135,135},
      thickness=0.5));
  connect(cycle.y[1], throttleAndBrake.throttle)
    annotation (Line(points={{-59,50},{-48,50},{-42,50}},
                                                 color={0,0,127}));
  connect(cycle.y[2], throttleAndBrake.brake) annotation (Line(points={{-59,50},
          {-50,50},{-50,56},{-42,56}}, color={0,0,127}));
  connect(battery.pin_p, genericDrive.pin_p) annotation (Line(points={{-64,10},
          {-64,10},{-64,22},{-24,22},{-24,10}},color={0,0,255}));
  connect(battery.pin_n, genericDrive.pin_n) annotation (Line(points={{-76,10},
          {-76,10},{-76,18},{-36,18},{-36,10}},
                                              color={0,0,255}));
  connect(rearAxleDrive.controlBus, genericDrive.controlBus) annotation (Line(
      points={{-10,6},{-14,6},{-14,30},{-44,30},{-44,-6},{-40,-6}},
      color={255,204,51},
      thickness=0.5));
  connect(rearAxleDrive.controlBus, battery.controlBus) annotation (Line(
      points={{-10,6},{-14,6},{-14,30},{-84,30},{-84,-6},{-80,-6}},
      color={255,204,51},
      thickness=0.5));
  connect(battery.heatPort, ambient.port) annotation (Line(points={{-76,-10},{
          -76,-26},{78,-26},{78,-30}},
                                   color={191,0,0}));
  connect(genericDrive.heatPort, ambient.port) annotation (Line(points={{-36,-10},
          {-36,-26},{78,-26},{78,-30}},        color={191,0,0}));
  connect(rearAxleDrive.heatPort, ambient.port) annotation (Line(points={{-10,-6},
          {-14,-6},{-14,-26},{78,-26},{78,-30}},         color={191,0,0}));
  connect(ambient.port, brakes4wheels.heatPort) annotation (Line(points={{78,-30},
          {78,-26},{66,-26},{66,-6},{70,-6}},         color={191,0,0}));
  connect(track.controlBus, driverEnvironment.controlBus) annotation (Line(
      points={{40,56},{30,56},{20,56}},
      color={255,204,51},
      thickness=0.5));
  connect(driverEnvironment.driverInterface, throttleAndBrake.driverInterface)
    annotation (Line(
      points={{0,50},{0,50},{-20,50}},
      color={85,85,255},
      thickness=0.5));
  annotation (experiment(StopTime=60, Interval=0.01),  Documentation(info="<html>
<p>
A full electric vehicle is driven along a track by an <a href=\"modelica://EMOTH.Drivers.ThrottleAndBrake\">external throttle (gas pedal [-1..+1]) and brake signal [0..1]</a>. 
Simulation terminates after the choosen simulation Stop time.
</p>
</html>"));
end TestWithThrottle;
