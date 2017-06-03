within EMOTH.Blocks;
block DirectionSwitch "Changes sign of input signal"
  extends Modelica.Blocks.Interfaces.SISO;
  Modelica.Blocks.Interfaces.BooleanInput switch annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
equation
  y = u*(if switch then 1 else -1);
  annotation (Documentation(info="<html>
<p>If boolean input switch is true, the output y = u, otherwise -u.</p>
</html>"));
end DirectionSwitch;
