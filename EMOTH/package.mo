within ;
package EMOTH "Electric Mobility OTH"
  extends Modelica.Icons.Package;

  annotation (version="1.5.0", versionDate="2021-04-19",
    uses(Modelica(version="4.0.0"), VehicleInterfaces(version="2.0.0")),
    preferredView="info", Documentation(info="<html>
<p><img src=\"modelica://EMOTH/Resources/Images/OTH_EI.png\" align=\"middle\"></p>
<p>
The <b>E</b>lectric <b>M</b>obility library of <a HREF=\"https://www.oth-regensburg.de/en.html\"><b>OTH</b> Regensburg</a> provides models for electric vehicle models based on standard interface definitions of the open source <a href=\"modelica://VehicleInterfaces\">Vehicle Interface library</a>.
</p>
</html>"),
    conversion(from(version={"1.4.1","1.4.0"}, script="modelica://EMOTH/Resources/ConvertFromEMOTH_1.4.1.mos")));
end EMOTH;
