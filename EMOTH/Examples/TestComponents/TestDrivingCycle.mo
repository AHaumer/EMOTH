within EMOTH.Examples.TestComponents;
model TestDrivingCycle "Test driving cycle"
  extends Modelica.Icons.Example;
  Drivers.DrivingCycle drivingCycle(
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    table=[0,0; 10,0; 20,35; 25,50; 75,50; 80,35; 90,0; 100,0],
    cycle=EMOTH.Drivers.Components.CycleType.NEDC,
    n=1)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Continuous.Integrator integratorPreview(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Sources.Constant tPreview(k=1)
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
protected
  Interfaces.DriverInterface driverInterface annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={0,0})));
equation
  connect(drivingCycle.driverInterface, driverInterface) annotation (Line(
      points={{-10,4.44089e-016},{-4,4.44089e-016},{-4,0},{0,0}},
      color={85,85,255},
      thickness=0.5));
  connect(integrator.u, driverInterface.vReference)
    annotation (Line(points={{18,0},{-0.03,0},{-0.03,0.03}}, color={0,0,127}));
  connect(integratorPreview.u, driverInterface.vPreview) annotation (Line(
        points={{18,30},{10,30},{10,0.03},{-0.03,0.03}}, color={0,0,127}));
  connect(tPreview.y, driverInterface.tPreview) annotation (Line(points={{-9,30},
          {-0.03,30},{-0.03,0.03}}, color={0,0,127}));
  annotation (experiment(
      StopTime=86400,
      Interval=0.1,
      Tolerance=1e-005), Documentation(info="<html>
<p>
Testing the <a href=\"modelica://EMOTH.Drivers.DrivingCycle\">driving cycle</a> v versus time.
</p>
</html>"));
end TestDrivingCycle;
