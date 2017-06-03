within EMOTH.Drivers;
model DrivingCycle "Definition of the driving cycle v(t)"
  extends EMOTH.Icons.DrivingCycle;
  import EMOTH.Drivers.Components.CycleType;
  parameter EMOTH.Drivers.Components.CycleType cycle "Type of driving cycle";
  parameter Boolean convert_from_kmh=true "Convert speed from km/h to m/s?"
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
  constant Real udc[:,2]=
  [00,  0;  11,  0;  15, 15;  23, 15;  28,  0;  49,  0;  55, 15;  61, 32;  85, 32;  96,  0;
  117,  0; 123, 15; 134, 35; 143, 50; 155, 50; 163, 35; 178, 35; 188,  0; 195,  0];
  constant Real eudc[:,2]=
  [00,  0;  20,  0;  26, 15;  37, 35;  47, 50;  61, 70; 111, 70; 119, 50; 188, 50; 201, 70;
  251, 70; 286,100; 316,100; 336,120; 346,120; 362, 80; 370, 50; 380,  0; 400, 0];
  constant Real nedc[:,2]=
  [000,  0;  11,  0;  15, 15;  23, 15;  28,  0;  49,  0;  55, 15;  61, 32;  85, 32;  96,  0;
   117,  0; 123, 15; 134, 35; 143, 50; 155, 50; 163, 35; 178, 35; 188,  0; 195,  0;
            206,  0; 210, 15; 218, 15; 223,  0; 244,  0; 250, 15; 256, 32; 280, 32; 291,  0;
   312,  0; 318, 15; 329, 35; 338, 50; 350, 50; 358, 35; 373, 35; 383,  0; 390,  0;
            401,  0; 405, 15; 413, 15; 418,  0; 439,  0; 445, 15; 451, 32; 475, 32; 486,  0;
   507,  0; 513, 15; 524, 35; 533, 50; 545, 50; 553, 35; 568, 35; 578,  0; 585,  0;
            596,  0; 600, 15; 608, 15; 613,  0; 634,  0; 640, 15; 646, 32; 670, 32; 681,  0;
   702,  0; 708, 15; 719, 35; 728, 50; 740, 50; 748, 35; 763, 35; 773,  0; 780,  0;
            800,  0; 806, 15; 817, 35; 827, 50; 841, 70; 891, 70; 899, 50; 968, 50; 981, 70;
  1031, 70;1066,100;1096,100;1116,120;1126,120;1142, 80;1150, 50;1160,  0;1180, 0];
  final parameter Real dc[:,2]=if cycle==CycleType.UDC then udc elseif cycle==CycleType.EUDC then eudc
    elseif cycle==CycleType.NEDC then nedc else table;
  final parameter Real kmh2ms=if convert_from_kmh or cycle==CycleType.UDC or cycle==CycleType.EUDC or cycle==CycleType.NEDC then 1/3.6 else 1;
public
  Modelica.Blocks.Math.Gain from_kmh(final k=kmh2ms)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Interfaces.DriverInterface driverInterface annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,3.55271e-015})));
  Blocks.CombiTable1Dse combiTable(
    final tableOnFile=tableOnFile,
    final table=dc,
    final tableName=tableName,
    final fileName=fileName,
    final extrapolation=extrapolation)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Clock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Blocks.CombiTable1Dse combiTablePreview(
    final tableOnFile=tableOnFile,
    final table=dc,
    final tableName=tableName,
    final fileName=fileName,
    final extrapolation=extrapolation)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
public
  Modelica.Blocks.Math.Gain from_kmhPreview(final k=kmh2ms)
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
<li>UDC urban driving cycle [0..195] s with vMax=50 km/h</li>
<li>EUDC extra urban driving cycle [0..400] s vMax=120 km/h</li>
<li>NEDC new European driving cycle [0..1180] s = 4 x UDC + 1 x EUDC</li>
<li>user defined by a table</li>
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
