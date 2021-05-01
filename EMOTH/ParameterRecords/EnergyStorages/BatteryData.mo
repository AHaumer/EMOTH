within EMOTH.ParameterRecords.EnergyStorages;
record BatteryData "Battery parameters"
  extends Modelica.Icons.Record;
  constant String DataName="empty" "Name of dataset";
  parameter Modelica.Units.SI.Voltage VDC "Nominal (no-load) DC voltage at SOC = 1";
  parameter Real SoCmin(final min=0, final max=1)=0.1 "Minimum state of charge";
  parameter Boolean useLinearSOCdependency=true "otherwise table-based"
    annotation(Dialog(group="SOC-Dependency"));
  parameter Modelica.Units.SI.Voltage VDCmin "Minimal (no-load) DC voltage at SOCmin"
    annotation(Dialog(group="SOC-Dependency", enable=useLinearSOCdependency));
  parameter String tableName="OCV_SOC" "Table name on file or in function usertab (see docu)"
    annotation(Dialog(group="SOC-Dependency", enable=not useLinearSOCdependency));
  parameter String fileName=
    ModelicaServices.ExternalReferences.loadResource("modelica://EMOTH/Resources/BatteryCharacteristics/OCV_SOC.txt")
    "File where matrix is stored"
    annotation (Dialog(group="SOC-Dependency", enable=not useLinearSOCdependency,
      loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
      caption="Open file in which table is present")));
  parameter Modelica.Units.SI.Resistance Ri
    "Inner DC resistance = VDC/I_ShortCircuit";
  parameter Modelica.Units.NonSI.ElectricCharge_Ah QNominal
    "Nominal electric charge";
  annotation(defaultComponentPrefixes="parameter", defaultComponentName="batteryData",
    Icon(graphics={Text(
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
