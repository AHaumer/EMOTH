within EMOTH.ElectricDrives.Components;
block ConstantEfficiency
  "Calculation of losses for constant efficiency"
  extends Modelica.Blocks.Interfaces.SISO;
  import Modelica.Constants.eps;
  parameter Real eta(final min = eps, final max = 1, start = 1)
    "Constant efficiency";
  parameter Modelica.Units.SI.Power p_min(final min=eps, start=eps)
    "Power limit for regularization";
equation
  y = u*(if u>eps then (1/eta - 1) else (1 - eta))*(2/(1 + exp(-u/(0.01*p_min))) - 1);
  annotation (Documentation(info="<html>
<p>
Calculates losses from mechanical power for constant efficiency.
</p>
<h4>Note:</h4>
<p>
This block is replaced by the more general block 
<a href=\"modelica://EMOTH.ElectricDrives.Components.DriveEfficiency\">DriveEfficiency</a> 
which can be use the same way for <code>useConstantMotorEfficiency = true</code>.
</p>
</html>"));
end ConstantEfficiency;
