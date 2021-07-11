within EMOTH.Interfaces;
expandable connector ControlBus
  "Bus of VehicleInterfaces: Minimal standard control bus"
  extends VehicleInterfaces.Interfaces.ControlBus;
  RexBus rexBus "Range extender bus"
  annotation(Dialog(enable=false));
  DynamometerBus dynamometerBus "Dynamometer bus"
  annotation(Dialog(enable=false));
  annotation (Documentation(info="<html>
<p>
Bus to exchange signals between all components, i.e. a summary of sub-busses. 
</p>
</html>"));
end ControlBus;
