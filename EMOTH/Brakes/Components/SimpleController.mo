within EMOTH.Brakes.Components;
model SimpleController "Simple brake controller"
  extends VehicleInterfaces.Icons.Controller;
  Interfaces.BrakesBus brakesBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealOutput fn_1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-110})));
  Modelica.Blocks.Interfaces.RealOutput fn_2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,110})));
  Modelica.Blocks.Interfaces.RealOutput fn_3 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-110})));
  Modelica.Blocks.Interfaces.RealOutput fn_4 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,110})));
equation
  connect(fn_2, brakesBus.fn_brake) annotation (Line(points={{-60,110},{-60,
          110},{-60,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(fn_1, brakesBus.fn_brake) annotation (Line(points={{-60,-110},{-60,
          -110},{-60,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(fn_4, brakesBus.fn_brake) annotation (Line(points={{60,110},{60,110},
          {60,0.05},{-100.05,0.05}}, color={0,0,127}));
  connect(fn_3, brakesBus.fn_brake) annotation (Line(points={{60,-110},{60,
          -110},{60,0.05},{-100.05,0.05}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Simple brake controller, distributing the brake signal from the brakesBus to all four wheels.
</p>
</html>"));
end SimpleController;
