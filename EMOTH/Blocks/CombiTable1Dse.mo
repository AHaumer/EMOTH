within EMOTH.Blocks;
block CombiTable1Dse "Extended version of CombiTable1Ds"
  extends Modelica.Blocks.Tables.CombiTable1Ds;
  import Modelica.Blocks.Tables.Internal.getTable1DValueNoDer;
  parameter Real y0[nout](each fixed=false) "Initial abscissa"
    annotation(Dialog(enable=false));
  parameter Real yE[nout](each fixed=false) "Final abscissa"
    annotation(Dialog(enable=false));
initial algorithm
  for i in 1:nout loop
    y0[i] :=getTable1DValueNoDer(tableID, i, u_min);
    yE[i] :=getTable1DValueNoDer(tableID, i, u_max);
  end for;
  annotation (Documentation(info="<html>
<p>
Extends from <a href=\"modelica://Modelica.Blocks.Tables.CombiTable1Ds\">CombiTable1Ds</a> providing the initial abscissa values <code>y0[nout]</code>.
</p>
</html>"));
end CombiTable1Dse;
