within EMOTH.ParameterRecords.ElectricDrives.GenericDrives;
record GenericDriveData "Generic drive parameters"
  extends Modelica.Icons.Record;
  import Modelica.SIunits.Conversions.from_rpm;
  constant String DataName="empty" "Name of dataset";
  parameter Modelica.SIunits.AngularVelocity wBase "Begin of field weakening";
  parameter Modelica.SIunits.Torque tauNominal "Nominal torque";
  parameter Modelica.SIunits.Power PNominal=tauNominal*wBase "Nominal power"
   annotation(Dialog(group="Result", enable=false));
  parameter Real eta "Constant efficiency";
  parameter Modelica.SIunits.Torque tauBreakDown "Breakdown torque";
  parameter Modelica.SIunits.Torque tauMax "Maximal torque";
  parameter Modelica.SIunits.Time T "Time constant of torque rise";
  parameter Modelica.SIunits.Inertia J "Moment of inertia";
   annotation(defaultComponentPrefixes="parameter", Icon(graphics={Text(
          extent={{-100,50},{100,0}},
          lineColor={28,108,200},
          textString="el.drive"),                                 Text(
          extent={{-100,-50},{100,-100}},
          lineColor={28,108,200},
          textString="%DataName")}),
    Documentation(info="<html>
<p>This parameter record summarizes the parameters of a generic electric drive.</p>
</html>"));
end GenericDriveData;
