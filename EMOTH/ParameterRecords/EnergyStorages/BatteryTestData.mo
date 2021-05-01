within EMOTH.ParameterRecords.EnergyStorages;
record BatteryTestData "Test battery parameters"
  extends BatteryData(
    DataName="TestBattery",
    VDC=400,
    SoCmin=0.1,
    useLinearSOCdependency=false,
    VDCmin=330,
    Ri=0.05,
    QNominal=100);
  annotation(defaultComponentPrefixes="parameter",  defaultComponentName="batteryData",
    Documentation(info="<html>
<p>Parameters for a test battery.</p>
</html>"));
end BatteryTestData;
