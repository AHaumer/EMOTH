within EMOTH.ParameterRecords.EnergyStorages;
record BatteryData "Battery parameters"
  extends Modelica.Icons.Record;
  constant String DataName="empty" "Name of dataset";
  parameter Modelica.Units.SI.Voltage VDC "Nominal (no-load) DC voltage";
  parameter Modelica.Units.SI.Voltage VDCmin
    "Minimal (no-load) DC voltage at SOCmin";
  parameter Modelica.Units.SI.Resistance Ri
    "Inner DC resistance = VDC/I_ShortCircuit";
  parameter Modelica.Units.NonSI.ElectricCharge_Ah QNominal
    "Nominal electric charge";
  parameter Real SoCmin=0.1 "Minimum state of charge";
  annotation(defaultComponentPrefixes="parameter", Icon(graphics={Text(
          extent={{-100,50},{100,0}},
          lineColor={28,108,200},
          textString="battery"),                                  Text(
          extent={{-100,-50},{100,-100}},
          lineColor={28,108,200},
          textString="%DataName")}),
    Documentation(info="<html>
<p>This parameter record summarizes the parameters of a battery.</p>
</html>"));
end BatteryData;
