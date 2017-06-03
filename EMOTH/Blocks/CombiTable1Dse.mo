within EMOTH.Blocks;
block CombiTable1Dse
  "Table look-up in one dimension (matrix/file) with one input and n outputs"
  extends Modelica.Blocks.Interfaces.SIMO(final nout=size(columns, 1));
  parameter Boolean tableOnFile=false
    "= true, if table is defined on file or in function usertab"
    annotation (Dialog(group="Table data definition"));
  parameter Real table[:, :] = fill(0.0, 0, 2)
    "Table matrix (grid = first column; e.g., table=[0,2])"
    annotation (Dialog(group="Table data definition",enable=not tableOnFile));
  parameter String tableName="NoName"
    "Table name on file or in function usertab (see docu)"
    annotation (Dialog(group="Table data definition",enable=tableOnFile));
  parameter String fileName="NoName" "File where matrix is stored"
    annotation (Dialog(
      group="Table data definition",
      enable=tableOnFile,
      loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
          caption="Open file in which table is present")));
  parameter Boolean verboseRead=true
    "= true, if info message that file is loading is to be printed"
    annotation (Dialog(group="Table data definition",enable=tableOnFile));
  parameter Integer columns[:]=2:size(table, 2)
    "Columns of table to be interpolated"
    annotation (Dialog(group="Table data interpretation"));
  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation"
    annotation (Dialog(group="Table data interpretation"));
  parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints
    "Extrapolation of data outside the definition range"
    annotation (Dialog(group="Table data interpretation"));
  final parameter Real u_min(fixed=false) "Minimum abscissa value defined in table";
  final parameter Real u_max(fixed=false) "Maximum abscissa value defined in table";
protected
  Real ui "internal abscissa value";
  Modelica.Blocks.Types.ExternalCombiTable1D tableID=
      Modelica.Blocks.Types.ExternalCombiTable1D(
        if tableOnFile then tableName else "NoName",
        if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
        table,
        columns,
        smoothness) "External table object";
  parameter Real tableOnFileRead(fixed=false)
    "= 1, if table was successfully read from file";

  function readTableData "Read table data from ASCII text or MATLAB MAT-file"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
    input Boolean forceRead = false
      "= true: Force reading of table data; = false: Only read, if not yet read.";
    input Boolean verboseRead
      "= true: Print info message; = false: No info message";
    output Real readSuccess "Table read success";
    external"C" readSuccess = ModelicaStandardTables_CombiTable1D_read(tableID, forceRead, verboseRead)
      annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
    annotation(__ModelicaAssociation_Impure=true);
  end readTableData;

  function getTableValue "Interpolate 1-dim. table defined by matrix"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
    input Integer icol;
    input Real u;
    input Real tableAvailable
      "Dummy input to ensure correct sorting of function calls";
    output Real y;
    external"C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u)
      annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
    annotation (derivative(noDerivative=tableAvailable) = getDerTableValue);
  end getTableValue;

  function getTableValueNoDer
    "Interpolate 1-dim. table defined by matrix (but do not provide a derivative function)"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
    input Integer icol;
    input Real u;
    input Real tableAvailable
      "Dummy input to ensure correct sorting of function calls";
    output Real y;
    external"C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u)
      annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
  end getTableValueNoDer;

  function getDerTableValue
    "Derivative of interpolated 1-dim. table defined by matrix"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
    input Integer icol;
    input Real u;
    input Real tableAvailable
      "Dummy input to ensure correct sorting of function calls";
    input Real der_u;
    output Real der_y;
    external"C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u)
      annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
  end getDerTableValue;

  function getTableUmin
    "Return minimum abscissa value of 1-dim. table"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
    input Real tableAvailable
      "Dummy input to ensure correct sorting of function calls";
    output Real uMin "Minimum abscissa value in table";
    external"C" uMin = ModelicaStandardTables_CombiTimeTable_minimumTime(tableID)
      annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
  end getTableUmin;

  function getTableUmax
    "Return maximum abscissa value of 1-dim. table"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
    input Real tableAvailable
      "Dummy input to ensure correct sorting of function calls";
    output Real uMax "Maximum abscissa value in table";
    external"C" uMax = ModelicaStandardTables_CombiTimeTable_maximumTime(tableID)
      annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
  end getTableUmax;

initial algorithm
  if tableOnFile then
    tableOnFileRead := readTableData(tableID, false, verboseRead);
  else
    tableOnFileRead := 1.;
  end if;
  u_min := getTableUmin(tableID, tableOnFileRead);
  u_max := getTableUmax(tableID, tableOnFileRead);
equation
  if tableOnFile then
    assert(tableName <> "NoName",
      "tableOnFile = true and no table name given");
  else
    assert(size(table, 1) > 0 and size(table, 2) > 0,
      "tableOnFile = false and parameter table is an empty matrix");
  end if;
  if extrapolation==Modelica.Blocks.Types.Extrapolation.NoExtrapolation then
    assert(u>=u_min and u<=u_max,
      "Input u left defined abscissa range of CombiTable1Dse");
  end if;
  if extrapolation==Modelica.Blocks.Types.Extrapolation.Periodic then
    assert(abs(u_min)<=Modelica.Constants.small,
      "For periodic extrapolation the abscissa of CombiTable1Dse has to start at 0");
  end if;
  if extrapolation==Modelica.Blocks.Types.Extrapolation.HoldLastPoint then
    ui = min(max(u, u_min), u_max);
  elseif extrapolation==Modelica.Blocks.Types.Extrapolation.Periodic then
    ui = u - u_max*integer(u/u_max);
  else
    ui = u;
  end if;
  if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
    for i in 1:nout loop
      y[i] = getTableValueNoDer(tableID, i, ui, tableOnFileRead);
    end for;
  else
    for i in 1:nout loop
      y[i] = getTableValue(tableID, i, ui, tableOnFileRead);
    end for;
  end if;
  annotation (
    Documentation(info="<html>
<p>
<b>Linear interpolation</b> in <b>one</b> dimension of a <b>table</b>.
Via parameter <b>columns</b> it can be defined how many columns of the
table are interpolated. If, e.g., icol={2,4}, it is assumed that one input
and 2 output signals are present and that the first output interpolates
via column 2 and the second output interpolates via column 4 of the
table matrix.
</p>
<p>
The grid points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the grid points and the
other columns contain the data to be interpolated. Example:
</p>
<pre>
   table = [0,  0;
            1,  1;
            2,  4;
            4, 16]
   If, e.g., the input u = 1.0, the output y =  1.0,
       e.g., the input u = 1.5, the output y =  2.5,
       e.g., the input u = 2.0, the output y =  4.0,
       e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).
</pre>
<ul>
<li> The interpolation is <b>efficient</b>, because a search for a new interpolation
     starts at the interval used in the last call.</li>
<li> If the table has only <b>one row</b>, the table value is returned,
     independent of the value of the input signal.</li>
<li> If the input signal <b>u</b> is <b>outside</b> of the defined <b>interval</b>, i.e.,
     u &gt; table[size(table,1),1] or u &lt; table[1,1], the corresponding value is computed by
    extrapolation according to the setting of parameter <b>extrapolation</b>:
<pre>
  extrapolation = 1: hold the first or last value of the table,
                     if outside of the table scope.
                = 2: extrapolate by using the derivative at the first/last table
                     points if outside of the table scope.
                     (If smoothness is LinearSegments or ConstantSegments
                     this means to extrapolate linearly through the first/last
                     two table points.).
                = 3: periodically repeat the table data
                     (periodical function).
                = 4: no extrapolation, i.e. extrapolation triggers an error
</pre></li>
<li> The grid values (first column) have to be strictly increasing.</li>
<li>Via parameter <b>smoothness</b> it is defined how the data is interpolated:
<pre>
  smoothness = 1: linear interpolation
             = 2: Akima interpolation: Smooth interpolation by cubic Hermite
                  splines such that der(y) is continuous, also if extrapolated.
             = 3: constant segments
             = 4: Fritsch-Butland interpolation: Smooth interpolation by cubic
                  Hermite splines such that y preserves the monotonicity and
                  der(y) is continuous, also if extrapolated.
             = 5: Steffen interpolation: Smooth interpolation by cubic Hermite
                  splines such that y preserves the monotonicity and der(y)
                  is continuous, also if extrapolated.
</pre></li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li> Explicitly supplied as <b>parameter matrix</b> \"table\",
     and the other parameters have the following values:
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>
<li> <b>Read</b> from a <b>file</b> \"fileName\" where the matrix is stored as
      \"tableName\". Both ASCII and MAT-file format is possible.
      (The ASCII format is described below).
      The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
      The library supports at least v4, v6 and v7 whereas v7.3 is optional.
      It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
      by command
<pre>
   save tables.mat tab1 tab2 tab3
</pre>
      or Scilab by command
<pre>
   savematfile tables.mat tab1 tab2 tab3
</pre>
      when the three tables tab1, tab2, tab3 should be used from the model.<br>
      Note, a fileName can be defined as URI by using the helper function
      <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>  Statically stored in function \"usertab\" in file \"usertab.c\".
      The matrix is identified by \"tableName\". Parameter
      fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
      preferred as otherwise the table is reallocated and transposed.
      See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
      documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from an ASCII-file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<pre>
-----------------------------------------------------
#1
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16
double tab2(5,2)   # another comment line
  0   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (        ), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Other characters, like trailing non comments, are not allowed in the file.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"),
    Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
    Line(points={{0.0,40.0},{0.0,-40.0}}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-60.0,20.0},{-30.0,40.0}}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-60.0,0.0},{-30.0,20.0}}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-60.0,-20.0},{-30.0,0.0}}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-60.0,-40.0},{-30.0,-20.0}})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-60,60},{60,-60}},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{-100,0},{-58,0}}, color={0,0,255}),
        Line(points={{60,0},{100,0}}, color={0,0,255}),
        Text(
          extent={{-100,100},{100,64}},
          textString="1 dimensional linear table interpolation",
          lineColor={0,0,255}),
        Line(points={{-54,40},{-54,-40},{54,-40},{54,40},{28,40},{28,-40},{-28,
              -40},{-28,40},{-54,40},{-54,20},{54,20},{54,0},{-54,0},{-54,-20},
              {54,-20},{54,-40},{-54,-40},{-54,40},{54,40},{54,-40}}, color={
              0,0,0}),
        Line(points={{0,40},{0,-40}}),
        Rectangle(
          extent={{-54,40},{-28,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,20},{-28,0}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,0},{-28,-20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,-20},{-28,-40}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-52,56},{-34,44}},
          textString="u",
          lineColor={0,0,255}),
        Text(
          extent={{-22,54},{2,42}},
          textString="y[1]",
          lineColor={0,0,255}),
        Text(
          extent={{4,54},{28,42}},
          textString="y[2]",
          lineColor={0,0,255}),
        Text(
          extent={{0,-40},{32,-54}},
          textString="columns",
          lineColor={0,0,255})}));
end CombiTable1Dse;
