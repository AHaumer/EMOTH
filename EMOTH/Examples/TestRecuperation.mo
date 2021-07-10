within EMOTH.Examples;
model TestRecuperation "Test with and without recuperation"
  extends EMOTH.Examples.ExampleTemplate(driverEnvironment(useDriverModel=true,
        useRecuperation=true), chassis(v(start=drivingCycle.v0)));
  extends Modelica.Icons.Example;
  EMOTH.Drivers.CruiseControl
                 cruiseControl(
    T=driveData.T,
    tauMax=driveData.tauMax,
    J=driveData.J,
    Rsub=vehicleData.Rsub,
    mDyn=vehicleData.mDyn)
                        annotation (
    Placement(transformation(extent = {{-40, 40}, {-20, 60}})));
  Drivers.DrivingCycle drivingCycle(
    n=0,
    tableOnFile=true,
    table = [0, 0; 5, 50; 20, 50; 25, 0; 40, 0; 50, 100; 170, 100; 180, 50; 210, 50; 220, 0; 240, 0],
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    cycle=EMOTH.Drivers.Components.CycleType.NEDC)                                                                                                                                                                                                         annotation (
    Placement(transformation(extent={{-40,70},{-20,90}})));
equation
  connect(cruiseControl.driverInterface, drivingCycle.driverInterface)
    annotation (Line(
      points={{-20,50},{-10,50},{-10,80},{-20,80}},
      color={85,85,255},
      thickness=0.5));
  connect(cruiseControl.driverInterface, driverEnvironment.driverInterface)
    annotation (Line(
      points={{-20,50},{0,50}},
      color={85,85,255},
      thickness=0.5));
  annotation (
    experiment(
      StopTime=86400,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>
A full electric vehicle is driven along a track by a <a href=\"modelica://EMOTH.Drivers.CruiseControl\">cruise control</a> device, 
following the <a href=\"modelica://EMOTH.Drivers.DrivingCycle\">driving cycle</a>. 
ElectricalAccessories and RangeExtender is omitted, rollingResistance, inclination and windSpeed are kept constant.
Consider adapting the stop time to the number of consecutive driving cycles. 
SoC of battery starts at 1.0; compare a simulation over a number of drivingCycles with and without recuperation (see driverEnvironment).
</p>
</html>"));
end TestRecuperation;
