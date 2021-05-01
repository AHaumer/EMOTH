within EMOTH.Tracks.Components;
block TrackDefinition "Define one parameter of the track"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter ParameterRecords.SingleTrackData trackData
    annotation (Placement(transformation(extent={{-78,60},{-58,80}})));
  parameter Real yMax "Upper limits of signal";
  parameter Real yMin "Lower limits of signal";
  Modelica.Blocks.Sources.Constant constantValue(k=trackData.ConstantValue) if trackData.useConstant
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Blocks.CombiTable1Dse combiTable1Dse(
    tableOnFile=trackData.tableOnFile,
    table=trackData.table,
    tableName=trackData.tableName,
    fileName=trackData.fileName,
    extrapolation=trackData.extrapolation) if not trackData.useConstant
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(final uMax=yMax, final uMin=yMin)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
equation
  connect(u, combiTable1Dse.u) annotation (Line(points={{-120,0},{-72,0},{-20,0},
          {-20,-20},{-12,-20}}, color={0,0,127}));
  connect(constantValue.y, limiter.u)
    annotation (Line(points={{11,20},{20,20},{20,0},{28,0}}, color={0,0,127}));
  connect(combiTable1Dse.y[1], limiter.u) annotation (Line(points={{11,-20},{20,
          -20},{20,0},{28,0}}, color={0,0,127}));
  connect(limiter.y, y)
    annotation (Line(points={{51,0},{110,0}},         color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Defines a property along the track, either als constant value or as user-defined table, consisting of two columns: 
The first column specifies in a strict monotonically rising order the position along the track (measured in m), the second column the property. 
The table can be given by the user or read from an external file. 
When the vehicle position leaves the position range defined in the table, the user can choose the behaviour:
</p>
<ul>
<li>HoldLastPoint: Hold the first/last table point outside of the table scope</li>
<li>LastTwoPoints: Extrapolate by using the derivative at the first/last table points outside of the table scope</li>
<li>Periodic: Repeat the table scope periodically</li>
<li>NoExtrapolation: Extrapolation triggers an error</li>
</ul>
<p>
Note: The table is linearly interpolated. 
</p>
</html>"));
end TrackDefinition;
