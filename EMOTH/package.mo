within ;
package EMOTH "Electric Mobility OTH"
  extends Modelica.Icons.Package;

  annotation (version="1.9.0", versionDate="2021-07-11",
    uses(Modelica(version="4.0.0"), VehicleInterfaces(version="2.0.0"),
      ModelicaServices(version="4.0.0")),
    preferredView="info", Documentation(info="<html>
<p><img src=\"modelica://EMOTH/Resources/Images/OTH_EI.png\" align=\"middle\"></p>
<p>
The <b>E</b>lectric <b>M</b>obility library of <a HREF=\"https://www.oth-regensburg.de/en.html\"><b>OTH</b> Regensburg</a> provides models for electric vehicle models based on standard interface definitions of the open source <a href=\"modelica://VehicleInterfaces\">Vehicle Interface library</a>.
</p>
</html>"),
    conversion(from(version={"1.4.1"}, script="modelica://EMOTH/Resources/ConvertFromEMOTH_1.4.1.mos"),
               from(version={"1.5.0"}, script="modelica://EMOTH/Resources/ConvertFromEMOTH_1.5.0.mos")));
end EMOTH;
