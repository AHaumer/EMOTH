within EMOTH.Examples.TestComponents;
model TestAccesories "Test accessories"
  extends Modelica.Icons.Example;

  EnergyStorages.SimpleBattery battery(batteryData(
      QNominal=100,
      VDC=100,
      Ri=0.1))
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Accessories.ElectricalAccessories electricalAccessories(P=10000,
      useConstantPower=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Accessories.RangeExtender rangeExtender(P=20000)
    annotation (Placement(transformation(extent={{40,-8},{60,12}})));
equation
  connect(battery.pin_p, electricalAccessories.pin_p) annotation (Line(points={
          {-44,10},{-44,20},{-44,22},{6,22},{6,10}}, color={0,0,255}));
  connect(battery.pin_n, electricalAccessories.pin_n) annotation (Line(points={
          {-56,10},{-56,18},{-6,18},{-6,10}}, color={0,0,255}));
  connect(battery.controlBus, electricalAccessories.controlBus) annotation (
      Line(
      points={{-60,-6},{-64,-6},{-64,-20},{-14,-20},{-14,-6},{-10,-6}},
      color={255,204,51},
      thickness=0.5));
  connect(electricalAccessories.controlBus, rangeExtender.controlBus)
    annotation (Line(
      points={{-10,-6},{-14,-6},{-14,-20},{36,-20},{36,-4},{40,-4}},
      color={255,204,51},
      thickness=0.5));
  connect(electricalAccessories.pin_n, rangeExtender.pin_n) annotation (Line(
        points={{-6,10},{-6,18},{44,18},{44,12}}, color={0,0,255}));
  connect(electricalAccessories.pin_p, rangeExtender.pin_p) annotation (Line(
        points={{6,10},{6,10},{6,22},{56,22},{56,12}}, color={0,0,255}));
  annotation (experiment(
      StopTime=7200,
      Interval=0.1,
      Tolerance=1e-005), Documentation(info="<html>
<p>
Testing the <a href=\"modelica://EMOTH.EnergyStorages.SimpleBattery\">simple battery</a> with an
<a href=\"modelica://EMOTH.Accessories.ElectricalAccessories\">electrical load</a> and a
<a href=\"modelica://EMOTH.Accessories.RangeExtender\">range extender</a>.
</p>
</html>"));
end TestAccesories;
