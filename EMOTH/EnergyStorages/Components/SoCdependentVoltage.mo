within EMOTH.EnergyStorages.Components;
block SoCdependentVoltage "Voltage dependent on SoC"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Modelica.Units.SI.Voltage VDC "Nominal (no-load) DC voltage";
  parameter Modelica.Units.SI.Voltage VDCmin
    "Minimal (no-load) DC voltage at SOCmin";
  parameter Real SoCmin=0.1 "Minimum state of charge";
equation
  y = VDC - (VDC - VDCmin)*(1 - u)/(1 - SoCmin);
end SoCdependentVoltage;
