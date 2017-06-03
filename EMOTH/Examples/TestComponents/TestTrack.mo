within EMOTH.Examples.TestComponents;
model TestTrack "Test track definition"
  extends Modelica.Icons.Example;
  parameter ParameterRecords.SingleTrackData       inclinationData(
    useConstant=false,
    table=[0,0; 200,0; 200.1,0.1; 299.9,0.1; 300,0; 1300,0; 1300.1,-0.1; 1399.9,-0.1; 1400,0; 1600,0],
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Definition of inclination versus position on track"
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  parameter ParameterRecords.SingleTrackData       rollingResistanceData(
      ConstantValue=0.02) "Definition of cR versus position on track"
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  Tracks.Track track(inclinationData=inclinationData,
    rollingResistanceData=rollingResistanceData)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
protected
  VehicleInterfaces.Interfaces.ControlBus controlBus1 annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-20,0})));
public
  Modelica.Blocks.Sources.Trapezoid speed(
    rising=5,
    width=40,
    falling=5,
    period=60,
    nperiod=1,
    amplitude=140/3.6)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Continuous.Integrator integratorPosition(k=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
equation
  connect(track.controlBus, controlBus1) annotation (Line(
      points={{-10,6},{-20,6},{-20,0}},
      color={255,204,51},
      thickness=0.5));
  connect(speed.y, integratorPosition.u) annotation (Line(points={{-59,20},{-50,
          20},{-50,0},{-90,0},{-90,-20},{-82,-20}}, color={0,0,127}));
  connect(speed.y, controlBus1.chassisBus.v) annotation (Line(points={{-59,20},
          {-40,20},{-40,0.03},{-20.03,0.03}}, color={0,0,127}));
  connect(integratorPosition.y, controlBus1.chassisBus.s) annotation (Line(
        points={{-59,-20},{-40,-20},{-40,0.03},{-20.03,0.03}}, color={0,0,127}));
  annotation (experiment(StopTime=60, Interval=0.1),
                         Documentation(info="<html>
<p>
Testing the <a href=\"modelica://EMOTH.Tracks.Track\">track definition</a>, e.g. the height calculated from inclination definition.
</p>
</html>"));
end TestTrack;
