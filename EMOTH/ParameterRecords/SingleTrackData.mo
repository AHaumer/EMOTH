within EMOTH.ParameterRecords;
record SingleTrackData "Singla data of a track"
  extends Modelica.Icons.Record;
  parameter Boolean useConstant=true "Use constant value, otherwise table";
  parameter Real ConstantValue=0 "Constant Value"
    annotation(Dialog(enable=useConstant));
  parameter Boolean tableOnFile=false
    "= true, if table is defined on file or in function usertab"
    annotation (Dialog(group="Table data definition", enable=not useConstant));
  parameter Real table[:, :] = fill(0.0, 0, 2)
    "Table matrix (grid = first column; e.g., table=[0,2])"
    annotation (Dialog(group="Table data definition", enable=not tableOnFile and not useConstant));
  parameter String tableName="NoName"
    "Table name on file or in function usertab (see docu)"
    annotation (Dialog(group="Table data definition",enable=tableOnFile and not useConstant));
  parameter String fileName="NoName" "File where matrix is stored"
    annotation (Dialog(
      group="Table data definition",
      enable=tableOnFile and not useConstant,
      loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
          caption="Open file in which table is present")));
  parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation
    "Extrapolation of data outside the definition range"
    annotation (Dialog(group="Table data interpretation", enable=not useConstant));
  annotation (defaultComponentPrefixes="parameter",
    Icon(graphics={Text(
          extent={{-100,50},{100,0}},
          lineColor={28,108,200},
          textString="trackData")}),
    Documentation(info="<html>
<p>
Parameter record for the <a href=\"modelica://EMOTH.Tracks.Components.TrackDefinition\">track definition block</a>.
</p>
</html>"));
end SingleTrackData;
