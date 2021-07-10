within EMOTH.Examples;
model TestWithThrottle "Test with external throttle and brake"
  extends EMOTH.Examples.ExampleTemplate(
    battery(includeHeatPort=true),
    genericDrive(includeHeatPort=true),
    brakes4wheels(includeHeatPort=true),
    rearAxleDrive(includeHeatPort=true),
    driverEnvironment(useDriverModel=false, useRecuperation=false),
    track(inclinationData=inclinationData, rollingResistanceData=rollingResistanceData));
  extends Modelica.Icons.Example;
  parameter EMOTH.ParameterRecords.SingleTrackData inclinationData(
    useConstant=false,
    table=[0,0; 200,0; 200.1,0.1; 299.9,0.1; 300,0; 1300,0; 1300.1,-0.1; 1399.9,-0.1; 1400,0; 1600,0],
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Definition of inclination versus position on track"
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  parameter EMOTH.ParameterRecords.SingleTrackData rollingResistanceData(
      ConstantValue=0.02) "Definition of cR versus position on track"
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
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
  connect(cycle.y[1], throttleAndBrake.throttle)
    annotation (Line(points={{-59,50},{-48,50},{-42,50}},
                                                 color={0,0,127}));
  connect(cycle.y[2], throttleAndBrake.brake) annotation (Line(points={{-59,50},
          {-50,50},{-50,56},{-42,56}}, color={0,0,127}));
  connect(battery.heatPort, ambient.port) annotation (Line(points={{-76,-10},{-76,
          -24},{78,-24},{78,-30}}, color={191,0,0}));
  connect(genericDrive.heatPort, ambient.port) annotation (Line(points={{-36,-10},
          {-36,-24},{78,-24},{78,-30}}, color={191,0,0}));
  connect(rearAxleDrive.heatPort, ambient.port) annotation (Line(points={{-10,-6},
          {-14,-6},{-14,-24},{78,-24},{78,-30}}, color={191,0,0}));
  connect(brakes4wheels.heatPort, ambient.port) annotation (Line(points={{20,-6},
          {16,-6},{16,-24},{78,-24},{78,-30}}, color={191,0,0}));
  connect(throttleAndBrake.driverInterface, driverEnvironment.driverInterface)
    annotation (Line(
      points={{-20,50},{0,50}},
      color={85,85,255},
      thickness=0.5));
  annotation (experiment(StopTime=60, Interval=0.01),  Documentation(info="<html>
<p>
A full electric vehicle is driven along a track by an <a href=\"modelica://EMOTH.Drivers.ThrottleAndBrake\">external throttle (gas pedal [-1..+1]) and brake signal [0..1]</a>. 
Simulation terminates after the choosen simulation Stop time.
</p>
</html>"));
end TestWithThrottle;
