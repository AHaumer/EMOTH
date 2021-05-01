within EMOTH.EnergyStorages.Components;
block SoCdependentVoltage "Voltage dependent on SoC"
  extends Modelica.Blocks.Interfaces.SISO;
  import Modelica.Constants.eps;
  parameter Modelica.Units.SI.Voltage VDC "Nominal (no-load) DC voltage at SOC = 1";
  parameter Real SoCmin(final min=0, final max=1)=0.1 "Minimum state of charge";
  parameter Boolean useLinearSOCdependency=true "otherwise table-based";
  parameter Modelica.Units.SI.Voltage VDCmin "Minimal (no-load) DC voltage at SOCmin"
    annotation(Dialog(enable=useLinearSOCdependency));
  parameter String tableName="None" "Table name on file or in function usertab (see docu)"
    annotation(Dialog(enable=not useLinearSOCdependency));
  parameter String fileName="None" "File where matrix is stored"
    annotation(Dialog(enable=not useLinearSOCdependency));
  Blocks.CombiTable1Dse combiTable1Dse(
    tableOnFile=not useLinearSOCdependency,
    table=tableSOC,
    tableName=tableName,
    fileName=fileName,
    smoothness=if useLinearSOCdependency then Modelica.Blocks.Types.Smoothness.LinearSegments else Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Gain gain(k=VDC)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
protected
  parameter Real tableSOC[2,2]=[SoCmin, VDCmin/VDC; 1,1] "OCV/VDC versus SOC";
equation
  assert(combiTable1Dse.u_min<=SoCmin, "Tabulated min SOC has to be <= SoCmin");
  assert(combiTable1Dse.y0[1]>0, "Tabulated min. voltage has to be > 0");
  assert(abs(combiTable1Dse.u_max - 1)<=eps, "Tabulated max. SOC has to be = 1");
  assert(abs(combiTable1Dse.yE[1] - 1)<=eps, "Tabulated max. voltage / nom. voltage has to be = 1");
  connect(u, combiTable1Dse.u)
    annotation (Line(points={{-120,0},{-12,0}}, color={0,0,127}));
  connect(combiTable1Dse.y[1], gain.u)
    annotation (Line(points={{11,0},{38,0}}, color={0,0,127}));
  connect(gain.y, y)
    annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
end SoCdependentVoltage;
