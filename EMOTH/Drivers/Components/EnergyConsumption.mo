within EMOTH.Drivers.Components;
block EnergyConsumption "Calculate energy consumption per distance"
  extends Modelica.Blocks.Interfaces.SI2SO(u1(unit="m"), u2(unit="J"), y(unit="kW.h/km"));
  parameter Modelica.Units.SI.Length dMin=1000
    "Minimum distance for calculation";
equation
  y=if noEvent(abs(u1)<dMin) then 0 else u2/u1/3600;
  annotation (Icon(graphics={Text(
          extent={{-100,80},{-60,40}},
          lineColor={28,108,200},
          textString="l"), Text(
          extent={{-100,-40},{-60,-80}},
          lineColor={28,108,200},
          textString="E")}));
end EnergyConsumption;
