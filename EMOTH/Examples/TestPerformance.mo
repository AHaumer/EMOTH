within EMOTH.Examples;
model TestPerformance
  "Determine maximum acceleration, maximum speed, range at max.speed"
  extends EMOTH.Examples.ExampleTemplate(
    driverEnvironment(useDriverModel=true, useRecuperation=true),
    track(inclinationData=inclinationData, rollingResistanceData=
          rollingResistanceData),
    chassis(v(start=drivingCycle.v0)));
  extends Modelica.Icons.Example;
  parameter EMOTH.ParameterRecords.SingleTrackData inclinationData
    "Definition of inclination versus position on track"
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  parameter EMOTH.ParameterRecords.SingleTrackData rollingResistanceData(
      ConstantValue=0.02) "Definition of cR versus position on track"
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  Drivers.Driver driver
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Drivers.DrivingCycle drivingCycle(
    cycle=EMOTH.Drivers.Components.CycleType.Table,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    n=0,
    table=[0,0; 1,250])
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
equation
  connect(driver.driverInterface, drivingCycle.driverInterface) annotation (
      Line(
      points={{-20,50},{-10,50},{-10,78},{-10,80},{-20,80}},
      color={85,85,255},
      thickness=0.5));
  connect(driver.driverInterface, driverEnvironment.driverInterface)
    annotation (Line(
      points={{-20,50},{0,50}},
      color={85,85,255},
      thickness=0.5));
  annotation (experiment(StopTime=86400, Interval=0.1),Documentation(info="<html>
<p>
A full electric vehicle is accelerated with maximum torque to maximum speed and driven until the battery is exhausted.
This is achieved by setting a simple driving cycle [0,0; 1,250], HoldLastPoint, no termination (n=0).
</p>
</html>"));
end TestPerformance;
