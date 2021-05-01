within EMOTH.ParameterRecords.ElectricDrives.GenericDrives;
record GenericDriveData "Generic drive parameters"
  extends Modelica.Icons.Record;
  import Modelica.Units.Conversions.from_rpm;
  import Modelica.Constants.eps;
  constant String DataName="empty" "Name of dataset";
  parameter Modelica.Units.SI.AngularVelocity wBase "Begin of field weakening";
  parameter Modelica.Units.SI.Torque tauNominal "Nominal torque";
  parameter Modelica.Units.SI.Power PNominal=tauNominal*wBase "Nominal power"
    annotation (Dialog(group="Result", enable=false));
  parameter Modelica.Units.SI.Torque tauBreakDown "Breakdown torque";
  parameter Modelica.Units.SI.Torque tauMax "Maximal torque";
  parameter Modelica.Units.SI.Time T "Time constant of torque rise";
  parameter Modelica.Units.SI.Inertia J "Moment of inertia";

  parameter Real InverterEfficiency(final min=eps, final max=1)=0.975 "Constant efficiency of inverter"
    annotation(Dialog(tab="Efficiency"));
  parameter Boolean useConstantMotorEfficiency=true "Otherwise using an efficiency table"
    annotation(Dialog(tab="Efficiency"));
  parameter Real MotorEfficiency(final min=eps, final max=1)=0.90 "Constant efficiency of motor"
    annotation(Dialog(tab="Efficiency", enable=useConstantMotorEfficiency));
  parameter String tableName="None" "Table name on file or in function usertab (see docu)"
    annotation(Dialog(tab="Efficiency", enable=not useConstantMotorEfficiency));
  parameter String fileName=" None" "File where matrix is stored"
    annotation (Dialog(tab="Efficiency", enable=not useConstantMotorEfficiency,
      loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
      caption="Open file in which table is present")));
  parameter Boolean tableSpeed_rpm=true "Efficiency table is given with speed in rpm, otherwise rad/s"
    annotation(Dialog(tab="Efficiency", enable=not useConstantMotorEfficiency));
   annotation(defaultComponentPrefixes="parameter", defaultComponentName="driveData",
     Icon(graphics={Text(
          extent={{-100,50},{100,0}},
          lineColor={28,108,200},
          textString="el.drive"), Text(
          extent={{-100,-50},{100,-100}},
          lineColor={28,108,200},
          textString="%DataName")}),
    Documentation(info="<html>
<p>This parameter record summarizes the parameters of a generic electric drive.</p>
</html>"));
end GenericDriveData;
