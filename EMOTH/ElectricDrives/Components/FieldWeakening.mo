within EMOTH.ElectricDrives.Components;
block FieldWeakening "Torque limits by field weakening block"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Modelica.SIunits.AngularVelocity wBase "Begin of field weakenng";
  parameter Modelica.SIunits.Torque tauBreakDown "Breakdown torque";
  parameter Modelica.SIunits.Torque tauMax "Maximal torque";
  Modelica.Blocks.Interfaces.RealInput w "Mechanical speed signal"
                                         annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
protected
  parameter Modelica.SIunits.AngularVelocity wFW2=wBase*0.95*tauBreakDown/tauMax "Field weakening 2";
equation
  if noEvent(abs(w)<wBase) then
    y = u*tauMax;
  elseif noEvent(abs(w)<wFW2) then
    y = u*tauMax*wBase/abs(w);
  else
    y = u*tauMax*wBase*wFW2/w^2;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This block calculates torque in Nm from the throttle signal (in the range [-1..+1]) according to field weakening.</p>
<p>Maximum or minimum throttle signal leads to maximum or minimum torque according to the actual speed.</p>
<p>Maximum torque is given by breakdown torque of the motor and maximum torque achieved by maximum current of the inverter.</p>
</html>"));
end FieldWeakening;
