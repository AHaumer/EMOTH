within EMOTH.ElectricDrives.Components;
model IdealPowerConverter
  "Ideal converter between mechanical and electrical power"
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  extends Modelica.Blocks.Icons.Block;
  parameter Boolean useLosses=true "Use loss input?";
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent
    annotation (Placement(transformation(extent={{40,10},{60,-10}})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealInput Pmechanical annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Math.Add3     feedback(
    final k2=+1,
    final k1=+1,
    final k3=-1)
    annotation (Placement(transformation(extent={{-10,-50},{10,-70}})));
  Modelica.Blocks.Continuous.Integrator integrator(k=1e6, initType=Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Blocks.Interfaces.RealInput Ploss if useLosses annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Sources.Constant const(final k=0) if not useLosses
    annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
protected
  Modelica.Blocks.Interfaces.RealInput PlossInternal annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-60,-80})));
equation
  connect(p, powerSensor.pc)
    annotation (Line(points={{-100,0},{-80,0},{-60,0}}, color={0,0,255}));
  connect(powerSensor.pc, powerSensor.pv)
    annotation (Line(points={{-60,0},{-60,10},{-50,10}}, color={0,0,255}));
  connect(powerSensor.nc, signalCurrent.p)
    annotation (Line(points={{-40,0},{40,0}}, color={0,0,255}));
  connect(powerSensor.nv, n) annotation (Line(points={{-50,-10},{-50,-20},{80,-20},
          {100,-20},{100,0}}, color={0,0,255}));
  connect(signalCurrent.n, n)
    annotation (Line(points={{60,0},{100,0},{100,0}}, color={0,0,255}));
  connect(integrator.y, signalCurrent.i)
    annotation (Line(points={{41,-60},{50,-60},{50,-7}}, color={0,0,127}));
  connect(powerSensor.power, feedback.u3) annotation (Line(points={{-58,-11},{
          -58,-11},{-58,-52},{-12,-52}}, color={0,0,127}));
  connect(Pmechanical, feedback.u1) annotation (Line(points={{0,-120},{0,-80},{
          -20,-80},{-20,-68},{-12,-68}}, color={0,0,127}));
  connect(feedback.y, integrator.u)
    annotation (Line(points={{11,-60},{11,-60},{18,-60}}, color={0,0,127}));
  connect(Ploss, PlossInternal)
    annotation (Line(points={{-60,-120},{-60,-80}}, color={0,0,127}));
  connect(const.y, PlossInternal) annotation (Line(points={{-79,-80},{-69.5,-80},
          {-60,-80}}, color={0,0,127}));
  connect(PlossInternal, feedback.u2) annotation (Line(points={{-60,-80},{-60,-80},
          {-60,-60},{-12,-60}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Based on the mechanical power and the losses, the dc current is calculated, taking actual dc voltage into account, by establishing a power balance with a very fast intergal controller.
</p>
</html>"));
end IdealPowerConverter;
