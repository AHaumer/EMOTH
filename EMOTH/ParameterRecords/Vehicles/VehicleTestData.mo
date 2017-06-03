within EMOTH.ParameterRecords.Vehicles;
record VehicleTestData "Vehicle data for testing"
  extends VehicleData(
    DataName="TestCar",
    m=1500,
    aNominal=5,
    vNominal=100/3.6,
    A=2,
    cw=0.5,
    rFront=0.3,
    JFront=0.25,
    rRear=0.3,
    JRear=0.25,
    ratioGear=5,
    etaGear=0.85,
    etaDiff=0.95);
  annotation(defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>Parameters for a test vehicle.</p>
</html>"));
end VehicleTestData;
