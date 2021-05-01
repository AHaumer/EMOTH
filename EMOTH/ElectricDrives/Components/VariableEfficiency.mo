within EMOTH.ElectricDrives.Components;
block VariableEfficiency
  "Calculation of losses for variable efficiency"
  extends Modelica.Blocks.Interfaces.SO;
  import Modelica.Constants.eps;
  parameter Modelica.Units.SI.Power p_min(final min=eps)=1e-3
    "Power limit for regularization";
  Modelica.Blocks.Interfaces.RealInput p
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput tau
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
protected
  Real eff=min(max(tau, 0),1);
equation
  if noEvent(p>p_min) then
    y = p*(1/eff - 1);
  elseif noEvent(p<-p_min) then
    y = -p*(1 - eff);
  else
    y = 0;
  end if;
  annotation (Documentation(info="<html>
<p>
Calculates losses from mechanical power for variable efficiency.
</p>
</html>"), Icon(graphics={Text(
          extent={{-90,80},{-52,40}},
          textColor={28,108,200},
          textString="p"), Text(
          extent={{-90,-40},{-52,-80}},
          textColor={28,108,200},
          textString="eta")}));
end VariableEfficiency;
