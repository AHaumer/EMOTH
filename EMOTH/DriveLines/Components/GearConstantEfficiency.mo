within EMOTH.DriveLines.Components;
model GearConstantEfficiency
  "Gearbox with constant efficiency w/o inertia"
  extends Modelica.Mechanics.Rotational.Icons.Gear;
  import Modelica.Constants.eps;
  parameter Real ratio(final min = eps, start = 1)
    "Transmission ratio (flange_a.phi/flange_b.phi)";
  parameter Real eta(final min = eps, final max = 1, start = 1)
    "Constant efficiency";
  parameter Modelica.SIunits.AngularVelocity w_min(final min = eps, start = eps)
    "Speed limit for regularization w.r.t. flange_a";
  parameter Modelica.SIunits.Torque tau_min(final min = eps, start = eps)
    "Torque limit for regularization w.r.t. flange_a";
  extends
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
  parameter Boolean useHeatPort = false "=true, if heatPort is enabled" annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(final Q_flow = -lossPower) if useHeatPort
    "Optional port to which dissipated losses are transported in form of heat"   annotation(Placement(transformation(extent = {{-110, 90}, {-90, 110}}), iconTransformation(extent = {{-110, 90}, {-90, 110}})));
  Modelica.SIunits.Angle phi_a "Angle between flange a and support";
  Modelica.SIunits.Angle phi_b "Angle between flange b and support";
  Modelica.SIunits.AngularVelocity w_a "Angular velocity between flange a and support";
  Modelica.SIunits.AngularVelocity w_b "Angular velocity between flange b and support";
  Modelica.SIunits.Torque tau_a "Torque at flange a";
  Modelica.SIunits.Torque tau_b "Torque at flange b";
  Modelica.SIunits.Torque tau_f "Friction torque";
  Modelica.SIunits.Power p_a "Power at flange a";
  Modelica.SIunits.Power p_b "Power at flange b";
  Modelica.SIunits.Power lossPower
    "Loss power leaving component via heatPort (> 0, if heat is flowing out of component)";
  Real eff "Efficiency";
equation
  phi_a = flange_a.phi - phi_support;
  phi_b = flange_b.phi - phi_support;
  w_a = der(phi_a);
  w_b = der(phi_b);
  tau_a = flange_a.tau;
  tau_b = flange_b.tau;
  p_a = tau_a * w_a;
  p_b = tau_b * w_b;
  phi_a = ratio * phi_b;
  tau_f = tau_a*(if (abs(p_a) - abs(p_b))>eps then 1 - eta else 1/eta - 1)*(2/(1 + exp(-tau_a/(0.01*tau_min))) - 1)*(2/(1 + exp(-w_a/(0.01*w_min))) - 1);
  tau_a*ratio + tau_b = tau_f*ratio;
  p_a + p_b = lossPower;
  eff = if noEvent((abs(p_a) - abs(p_b))>eps) then -p_b/p_a elseif noEvent((abs(p_b) - abs(p_a))>eps) then -p_a/p_b else 1;
  annotation(Icon(coordinateSystem(preserveAspectRatio = false), graphics={  Text(extent = {{-100, 120}, {100, 100}}, lineColor = {28, 108, 200}, textString = "%name"), Polygon(fillColor = {191, 0, 0}, pattern = LinePattern.None,
            fillPattern =                                                                                                    FillPattern.Solid, points = {{-50, 40}, {-70, 40}, {-70, 80}, {-60, 80}, {-80, 100}, {-100, 80}, {-90, 80}, {-90, 20}, {-50, 20}, {-50, 40}}, lineColor = {191, 0, 0})}), Diagram(coordinateSystem(preserveAspectRatio = false)), Documentation(info = "<html>
<p>
This is a simple model of a gearbox with constant efficiency without inertia.<br>
The relationship between torque at flange_a and flange_b is different depending on whether flange_a or flange_b is driving. 
To avoid a step in the relationship, efficiency rises from a threshold p_min towards zero to 1; i.e.at speed zero, torque at flange_b is ratio * torque at flange_a.
</p>
<pre>
  if p_a > 0 then // flange_a is driving
    tau_a*ratio*(1 -(1 - eta)*min(1, p_a/p_min)) + tau_b = 0;
  else              // flange_b is driving
    tau_a*ratio + tau_b*(1 -(1 - eta)*min(1, p_b/p_min)) = 0;
  end if;
</pre>
<p>
Losses are fed to the optional heatPort.
</p>
</html>"));
end GearConstantEfficiency;
