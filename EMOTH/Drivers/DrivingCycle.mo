within EMOTH.Drivers;
model DrivingCycle "Definition of the driving cycle v(t)"
  extends EMOTH.Icons.DrivingCycle;
  import EMOTH.Drivers.Components.CycleType;
  import EMOTH.Drivers.Components.SpeedConversion;
  parameter EMOTH.Drivers.Components.CycleType cycle "Type of driving cycle";
  parameter EMOTH.Drivers.Components.SpeedConversion speedConversion=EMOTH.Drivers.Components.SpeedConversion.kmh "Speed conversion"
    annotation(Dialog(enable=cycle==CycleType.Table));
  parameter Integer n=0 "Terminate after n  cycles (n<= means no termination)";
  parameter Boolean tableOnFile=false
    "= true, if table is defined on file or in function usertab"
    annotation (Dialog(group="Table data definition", enable=cycle==CycleType.Table));
  parameter Real table[:, 2] = fill(0.0, 0, 2)
    "Table matrix (grid = first column; e.g., table=[0,2])"
    annotation (Dialog(group="Table data definition", enable=not tableOnFile and cycle==CycleType.Table));
  parameter String tableName="NoName"
    "Table name on file or in function usertab (see docu)"
    annotation (Dialog(group="Table data definition",enable=tableOnFile and cycle==CycleType.Table));
  parameter String fileName="NoName" "File where matrix is stored"
    annotation (Dialog(
      group="Table data definition",
      enable=tableOnFile and cycle==CycleType.Table,
      loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
          caption="Open file in which table is present")));
  parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation
    "Extrapolation of data outside the definition range"
    annotation (Dialog(group="Table data interpretation"));
  final parameter Modelica.SIunits.Time t_min=combiTable.u_min "Mimimum time of table";
  final parameter Modelica.SIunits.Time t_max=combiTable.u_max "Maximum time of table";
protected
  final parameter Real conversionFactor=
    if (cycle==CycleType.Table and speedConversion==SpeedConversion.kmh)
    or  cycle==CycleType.UDC or cycle==CycleType.EUDC or cycle==CycleType.NEDC or cycle==CycleType.WLTC then 1/3.6
    elseif (cycle==CycleType.Table and speedConversion==SpeedConversion.mph) or cycle==CycleType.FTP75 then 1.609344/3.6
    else 1;
  final parameter Boolean internalTableOnFile=
    if cycle==CycleType.Table then tableOnFile else true;
  final parameter String internalTableName=
    if cycle==CycleType.Table then tableName
    elseif cycle==CycleType.UDC then "UDC"
    elseif cycle==CycleType.EUDC then "EUDC"
    elseif cycle==CycleType.NEDC then "NEDC"
    elseif cycle==CycleType.WLTC then "WLTC_class3"
    elseif cycle==CycleType.FTP75 then "FTP75"
    else "NoName";
  constant String fileNames[:]={
    Modelica.Utilities.Files.loadResource("modelica://EMOTH/Resources/DrivingCycles/NEDC.txt"),
    Modelica.Utilities.Files.loadResource("modelica://EMOTH/Resources/DrivingCycles/WLTC.txt"),
    Modelica.Utilities.Files.loadResource("modelica://EMOTH/Resources/DrivingCycles/FTP75.txt")};
  final parameter String internalFileName=
    if cycle==CycleType.Table then fileName
    elseif cycle==CycleType.UDC or cycle==CycleType.EUDC or cycle==CycleType.NEDC then fileNames[1]
    elseif cycle==CycleType.WLTC then fileNames[2]
    elseif cycle==CycleType.FTP75 then fileNames[3]
    else "NoName";
public
  Modelica.Blocks.Math.Gain from_kmh(final k=conversionFactor)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Interfaces.DriverInterface driverInterface annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,3.55271e-015})));
  Blocks.CombiTable1Dse combiTable(
    final extrapolation=extrapolation, tableOnFile=internalTableOnFile,
    final table=table,
    final tableName=internalTableName,
    final fileName=internalFileName)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Clock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Blocks.CombiTable1Dse combiTablePreview(
    final extrapolation=extrapolation, final tableOnFile=internalTableOnFile,
    final table=table,
    final tableName=internalTableName,
    final fileName=internalFileName)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Blocks.Math.Gain from_kmhPreview(final k=conversionFactor)
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Logical.TerminateSimulation terminateSimulation(condition=if
        n <= 0 then false else time >= n*t_max)
    annotation (Placement(transformation(extent={{-40,-74},{40,-66}})));
equation
  connect(clock.y, combiTable.u)
    annotation (Line(points={{-59,0},{-59,0},{-12,0}},   color={0,0,127}));
  connect(combiTable.y[1], from_kmh.u)
    annotation (Line(points={{11,0},{38,0}},        color={0,0,127}));
  connect(from_kmh.y, driverInterface.vReference)
    annotation (Line(points={{61,0},{100.1,0},{100.1,-0.1}}, color={0,0,127}));
  connect(combiTablePreview.y[1], from_kmhPreview.u)
    annotation (Line(points={{11,40},{38,40}}, color={0,0,127}));
  connect(from_kmhPreview.y, driverInterface.vPreview) annotation (Line(points=
          {{61,40},{70,40},{80,40},{80,-0.1},{100.1,-0.1}}, color={0,0,127}));
  connect(clock.y, add.u2) annotation (Line(points={{-59,0},{-50,0},{-50,34},{
          -42,34}}, color={0,0,127}));
  connect(add.y, combiTablePreview.u)
    annotation (Line(points={{-19,40},{-12,40}}, color={0,0,127}));
  connect(add.u1, driverInterface.tPreview) annotation (Line(points={{-42,46},{
          -50,46},{-50,60},{100.1,60},{100.1,-0.1}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Defines the driving cycle v(t) as one of the following choices:
</p>
<ul>
<li>user defined by a table</li>
<li>UDC urban driving cycle [0..195] s with vMax=50 km/h</li>
<li>EUDC extra urban driving cycle [0..400] s with vMax=120 km/h</li>
<li>NEDC new European driving cycle [0..1180] s = 4 x UDC + 1 x EUDC</li>
<li>WLTC Worldwide Harmonized Light-Duty Vehicles Test Procedure - Class 3 [0..1800] s with vMax=131.3 km/h</li>
<li>FTP75 EPA Federal Test Procedure - 75 [0..1874] s with vMax=56.7 mph=91.25 km/h</li>
</ul>
<p>
The first column specifies in a strict monotonically rising order the time (measured in s), the second column the speed (either in m/s or km/s). 
The table can be given by the user or read from an external file. 
If the speed is given in km/h, the user has to set the parameter convert_from_kmh=true. 
When the time leaves the time range defined in the table, the user can choose the behaviour:
</p>
<ul>
<li>HoldLastPoint: Hold the first/last table point outside of the table scope</li>
<li>LastTwoPoints: Extrapolate by using the derivative at the first/last table points outside of the table scope</li>
<li>Periodic: Repeat the table scope periodically</li>
<li>NoExtrapolation: Extrapolation triggers an error</li>
</ul>
<p>
Note: The table is linearly interpolated. 
The user may choose that (in case of periodic extrapolation) after a given count of cycles n the simulation is terminated (if the simulation Stop time is set long enough).  
Note: If n&le;0, the simulaton is terminated by the simulation Stop time.
</p>
</html>"));
end DrivingCycle;
