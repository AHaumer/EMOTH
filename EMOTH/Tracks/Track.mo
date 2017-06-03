within EMOTH.Tracks;
model Track "Simple description of track"
  extends Icons.Track;
  parameter ParameterRecords.SingleTrackData inclinationData
    "Definition of inclination versus position on track"
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  parameter ParameterRecords.SingleTrackData rollingResistanceData
    "Definition of cR versus position on track"
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  parameter Boolean useConstantWind=true "Use constant wind, otherwise input"
    annotation(Dialog(group="Wind"));
  parameter Boolean convert_from_kmh=true "Convert input signal from km/h?"
  annotation(Dialog(group="Wind", enable=not useConstantWind));
  parameter Modelica.SIunits.Velocity VWind(displayUnit="km/h")=0 "Constant wind speed (>0 in direction of track)"
    annotation(Dialog(group="Wind", enable=useConstantWind));
  parameter Modelica.SIunits.Position x0=0 "Initial horizontal x-position of vehicle"
    annotation(Dialog(group="Initialization"));
  parameter Modelica.SIunits.Position z0=0 "Initial vertical z-position of vehicle"
    annotation(Dialog(group="Initialization"));

  VehicleInterfaces.Interfaces.ControlBus controlBus annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,60})));
  Modelica.Blocks.Interfaces.RealInput vWind if not useConstantWind
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Math.Gain from_kmh(final k=if convert_from_kmh then 1/3.6 else 1) if not useConstantWind
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));

  Modelica.Blocks.Sources.Constant constantWind(final k=VWind) if useConstantWind
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Components.XzPosition xzPosition(final x0=x0, final z0=z0)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Components.TrackDefinition inclinationDefinition(
    final trackData=inclinationData,
    final yMax=1,
    final yMin=-1)
   annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Components.TrackDefinition rollingResistanceDefinition(
    final trackData=rollingResistanceData,
    final yMax=1,
    final yMin=0)
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
protected
  Interfaces.ChassisBus chassisBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,0})));
equation
  connect(chassisBus, controlBus.chassisBus) annotation (Line(
      points={{80,0},{100.1,0},{100.1,59.9}},
      color={255,204,51},
      thickness=0.5));
  connect(xzPosition.inclination, chassisBus.inclination) annotation (Line(
        points={{38,6},{20,6},{20,20},{80.05,20},{80.05,-0.05}}, color={0,0,127}));
  connect(xzPosition.z, chassisBus.z) annotation (Line(points={{61,6},{80.05,6},
          {80.05,-0.05}}, color={0,0,127}));
  connect(xzPosition.x, chassisBus.x) annotation (Line(points={{61,-6},{80.05,-6},
          {80.05,-0.05}}, color={0,0,127}));
  connect(xzPosition.v, chassisBus.v) annotation (Line(points={{38,-6},{20,-6},{
          20,-20},{80.05,-20},{80.05,-0.05}}, color={0,0,127}));
  connect(inclinationDefinition.u, chassisBus.s) annotation (Line(points={{38,80},
          {20,80},{20,60},{80.05,60},{80.05,-0.05}}, color={0,0,127}));
  connect(inclinationDefinition.y, chassisBus.inclination) annotation (Line(
        points={{61,80},{80.05,80},{80.05,-0.05}}, color={0,0,127}));
  connect(rollingResistanceDefinition.u, chassisBus.s) annotation (Line(points={
          {38,40},{20,40},{20,60},{80.05,60},{80.05,-0.05}}, color={0,0,127}));
  connect(rollingResistanceDefinition.y, chassisBus.cr) annotation (Line(points=
         {{61,40},{80.05,40},{80.05,-0.05}}, color={0,0,127}));
  connect(constantWind.y, chassisBus.vWind) annotation (Line(points={{-69,30},{-60,
          30},{-60,100},{80.05,100},{80.05,-0.05}}, color={0,0,127}));
  connect(vWind, from_kmh.u)
    annotation (Line(points={{-120,0},{-92,0},{-92,0}}, color={0,0,127}));
  connect(from_kmh.y, chassisBus.vWind) annotation (Line(points={{-69,0},{-60,0},
          {-60,100},{80.05,100},{80.05,-0.05}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
The track model defines:
</p>
<ul>
<li>The inclination along the track, either als constant value or as user-defined table.</li>
<li>The rolling resistance coefficient along the track, either als constant value or as user-defined table.</li>
<li>Wind speed, either as constant value or as input signal.</li>
</ul>
<p>
The wind speed input signal can be either in m/s or km/h, but the user has to specify whether conversion has be done or not via parameter convert_from_kmh. 
Positive wind speed is counted in positive direction of the track.
</p>
<p>
The user-defined tables for inclination and rolling resistance coefficient use the same <a href=\"modelica://EMOTH.Tracks.Components.TrackDefinition\">track definition block</a> 
with the same <a href=\"modelica://EMOTH.Tracks.Components.SingleTrackData\">parameter record</a>.
</p>
<p>
Additionally, the horizontal x-position and the vertical z-position along the track are calculated, using the <a href=\"modelica://EMOTH.Tracks.Components.XzPosition\">x z position block</a>
</p>
</html>"));
end Track;
