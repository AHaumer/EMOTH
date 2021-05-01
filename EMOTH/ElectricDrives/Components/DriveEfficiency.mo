within EMOTH.ElectricDrives.Components;
block DriveEfficiency
  "Calculate loss for the drive from constant or table efficiency"
  import Modelica.Constants.pi;
  import Modelica.Constants.eps;
  extends Modelica.Blocks.Interfaces.SO;
  parameter Real InverterEfficiency(final min=eps, final max=1)=0.975 "Constant efficiency of inverter";
  parameter Boolean useConstantMotorEfficiency=true "Otherwise using an efficiency table";
  parameter Real MotorEfficiency(final min=eps, final max=1)=0.90 "Constant efficiency of motor"
    annotation(Dialog(enable=useConstantMotorEfficiency));
  parameter String tableName="None" "Table name on file or in function usertab (see docu)"
    annotation(Dialog(enable=not useConstantMotorEfficiency));
  parameter String fileName=" None" "File where matrix is stored"
    annotation (Dialog(enable=not useConstantMotorEfficiency,
      loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
      caption="Open file in which table is present")));
  parameter Boolean tableSpeed_rpm=true "Efficiency table is given with speed in rpm, otherwise rad/s"
    annotation(Dialog(enable=not useConstantMotorEfficiency));
  Modelica.Blocks.Interfaces.RealInput w
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput tau
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Math.Product pMech
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Blocks.Math.Gain w2n(k=if tableSpeed_rpm then 30/pi else 1) if not useConstantMotorEfficiency
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,0})));
  Modelica.Blocks.Tables.CombiTable2Ds etaMotorTable(
    tableOnFile=true,
    tableName=tableName,
    fileName=fileName,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint) if not useConstantMotorEfficiency
    annotation (Placement(transformation(extent={{-50,-30},{-30,-50}})));
  Modelica.Blocks.Sources.Constant etaMotor(k=MotorEfficiency) if
                                               useConstantMotorEfficiency
    annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  Modelica.Blocks.Sources.Constant etaInverter(k=InverterEfficiency)
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  Modelica.Blocks.Math.Product etaTotal
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  VariableEfficiency variableEfficiency
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Math.Abs abs1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,30})));
equation
  connect(w, pMech.u1) annotation (Line(points={{-120,60},{-60,60},{-60,46},{
          -12,46}},
                color={0,0,127}));
  connect(tau, pMech.u2) annotation (Line(points={{-120,-60},{-60,-60},{-60,34},
          {-12,34}}, color={0,0,127}));
  connect(etaMotorTable.u2, w2n.y)
    annotation (Line(points={{-52,-34},{-80,-34},{-80,-11}}, color={0,0,127}));
  connect(tau, etaMotorTable.u1) annotation (Line(points={{-120,-60},{-60,-60},{
          -60,-46},{-52,-46}}, color={0,0,127}));
  connect(etaMotorTable.y, etaTotal.u1) annotation (Line(points={{-29,-40},{-20,
          -40},{-20,-34},{-12,-34}}, color={0,0,127}));
  connect(etaTotal.u1, etaMotor.y) annotation (Line(points={{-12,-34},{-20,-34},
          {-20,-10},{-29,-10}}, color={0,0,127}));
  connect(etaInverter.y, etaTotal.u2) annotation (Line(points={{-29,-70},{-20,
          -70},{-20,-46},{-12,-46}}, color={0,0,127}));
  connect(etaTotal.y, variableEfficiency.tau) annotation (Line(points={{11,-40},
          {20,-40},{20,-6},{28,-6}}, color={0,0,127}));
  connect(pMech.y,variableEfficiency.p)
    annotation (Line(points={{11,40},{20,40},{20,6},{28,6}}, color={0,0,127}));
  connect(variableEfficiency.y, y)
    annotation (Line(points={{51,0},{110,0}}, color={0,0,127}));
  connect(abs1.y, w2n.u)
    annotation (Line(points={{-80,19},{-80,12}}, color={0,0,127}));
  connect(w, abs1.u)
    annotation (Line(points={{-120,60},{-80,60},{-80,42}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                          Text(
          extent={{-90,80},{-48,40}},
          textColor={28,108,200},
          textString="w"), Text(
          extent={{-90,-40},{-48,-80}},
          textColor={28,108,200},
          textString="tau")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html
<p>
Fed by torque and angular velocity of the motor, taking into account constant efficiency of the inverter and 
either constant efficiency of the motor or performing a table lookup for motor efficiency, the losses of inverter and motor are calculated.
</p>
<p>
Motor efficiency can be specified either to be constant, or as a table dependent on speed an torque. 
The efficiency table has to given dependent on (postive and negative!) torque in rows and speed in columns. 
Efficiency is supposed to be the same in both directions of rotation, i.e. the table has to be specified only in positive drection of rotation. 
Interpolation is performed as spline interpolation with continuous derivative. 
Extrapolation beyond the specified table is done by holding the last table point. 
</p>
<h4>Note:</h4>
<p>
For abs(p) &lt; p_min, losses are assumed to be = 0.
</p>
</html>"));
end DriveEfficiency;
