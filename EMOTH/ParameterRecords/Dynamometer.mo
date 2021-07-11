within EMOTH.ParameterRecords;
package Dynamometer "Collection of dynamometer parameters"
  extends Modelica.Icons.MaterialPropertiesPackage;

  record DynamometerData "Dynamometer parameters"
    extends Modelica.Icons.Record;
    constant String DataName="empty" "Name of dataset";
  //Rolling Resistance
    parameter Real cr "Rolling resistance coefficient wheel-roll";
  //Rolls
    parameter Modelica.Units.SI.Length rRoll "Roll radius"
      annotation (Dialog(group="Rolls"));
    parameter Modelica.Units.SI.Inertia JRoll "Roll inertia"
      annotation (Dialog(tab="Rolls"));

    annotation(defaultComponentPrefixes="parameter", defaultComponentName="dynamometerData",
      Icon(graphics={Text(
            extent={{-100,-50},{100,-100}},
            lineColor={28,108,200},
            textString="%DataName"), Text(
            extent={{-100,50},{100,0}},
            lineColor={28,108,200},
            textString="vehicle")}),
      Documentation(info="<html>
<p>This parameter record summarizes the parameters of a chassis dynamometer.</p>
</html>"));
  end DynamometerData;

  record DynamometerTestData "Dynamometer test data"
    extends DynamometerData(
      DataName="TestDyno",
      cr=0.01,
      rRoll=48*0.254,
      JRoll=2);
    annotation(defaultComponentPrefixes="parameter", defaultComponentName="dynamometerData",
      Documentation(info="<html>
<p>Parameters for a typical dynamometer.</p>
</html>"));
  end DynamometerTestData;
annotation (Documentation(info="<html>
<p>
Collection of dynamometer parameter records, extending from the base <a href=\"modelica://EMOTH.ParameterRecords.Dnyamometer.DynamometerData\">dnyamometer data record</a>.
</p>
</html>"));
end Dynamometer;
