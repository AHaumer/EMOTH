within EMOTH.Examples;
model TestWithDriver "Test with driver over a driving cycle"
  extends EMOTH.Examples.ExampleTemplate(
    driverEnvironment(useDriverModel=true, useRecuperation=true),
    chassis(v(start=drivingCycle.v0)),
    track(inclinationData=inclinationData, rollingResistanceData=
          rollingResistanceData));
  extends Modelica.Icons.Example;
  parameter EMOTH.ParameterRecords.SingleTrackData inclinationData "Definition of inclination versus position on track" annotation (
    Placement(transformation(extent = {{20, 70}, {40, 90}})));
  parameter EMOTH.ParameterRecords.SingleTrackData rollingResistanceData(ConstantValue = 0.02) "Definition of cR versus position on track" annotation (
    Placement(transformation(extent = {{60, 70}, {80, 90}})));
  Drivers.Driver driver annotation (
    Placement(transformation(extent = {{-40, 40}, {-20, 60}})));
  Drivers.DrivingCycle drivingCycle(table = [0, 0; 5, 50; 20, 50; 25, 0; 40, 0; 50, 100; 170, 100; 180, 50; 210, 50; 220, 0; 240, 0],
    n=-1,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    cycle=EMOTH.Drivers.Components.CycleType.WLTC)                                                                                                                                                                                                         annotation (
    Placement(transformation(extent = {{-40, 70}, {-20, 90}})));
  EMOTH.Accessories.ElectricalAccessories electricalAccessories(P = 5000) annotation (
    Placement(transformation(extent = {{-60, -90}, {-40, -70}})));
  EMOTH.Accessories.RangeExtender rangeExtender(P = 6000) annotation (
    Placement(transformation(extent = {{-20, -90}, {0, -70}})));
equation
  connect(driver.driverInterface, drivingCycle.driverInterface) annotation (
    Line(points = {{-20, 50}, {-10, 50}, {-10, 78}, {-10, 80}, {-20, 80}}, color = {85, 85, 255}, thickness = 0.5));
  connect(electricalAccessories.controlBus, rangeExtender.controlBus) annotation (
    Line(points={{-60,-86},{-84,-86},{-84,-94},{-24,-94},{-24,-86},{-20,-86}},              color = {255, 204, 51}, thickness = 0.5));
  connect(driver.driverInterface, driverEnvironment.driverInterface)
    annotation (Line(
      points={{-20,50},{-10,50},{-10,50},{0,50}},
      color={85,85,255},
      thickness=0.5));
  connect(battery.pin_n, electricalAccessories.pin_n) annotation (Line(points=
         {{-76,10},{-76,18},{-56,18},{-56,-70}}, color={0,0,255}));
  connect(battery.pin_p, electricalAccessories.pin_p) annotation (Line(points=
         {{-64,10},{-64,22},{-50,22},{-50,-60},{-44,-60},{-44,-70}}, color={0,
          0,255}));
  connect(electricalAccessories.pin_p, rangeExtender.pin_p) annotation (Line(
        points={{-44,-70},{-44,-60},{-4,-60},{-4,-70}}, color={0,0,255}));
  connect(electricalAccessories.pin_n, rangeExtender.pin_n) annotation (Line(
        points={{-56,-70},{-56,-64},{-16,-64},{-16,-70}}, color={0,0,255}));
  connect(rearAxleDrive.controlBus, electricalAccessories.controlBus)
    annotation (Line(
      points={{-10,6},{-14,6},{-14,30},{-84,30},{-84,-86},{-60,-86}},
      color={255,204,51},
      thickness=0.5));
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
