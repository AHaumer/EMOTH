within EMOTH.ParameterRecords.EnergyStorages;
record BatteryTestData "Test battery parameters"
  extends BatteryData(
    DataName="TestBattery",
    VDC=400,
    Ri=0.05,
    QNominal=100);
  annotation(defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>Parameters for a test battery.</p>
</html>"));
end BatteryTestData;
