within EMOTH.Drivers;
package Components "Driver components"
  extends Modelica.Icons.VariantsPackage;

  type LinearEnergyConsumption = Real (final quantity="LinearEnergyConsumption",
        final unit="kW.h/km") "Energy consumption per distance";

annotation (Documentation(info="<html>
<p>
Components for driver models and driving cycles.
</p>
</html>"));
end Components;
