within EMOTH.ParameterRecords.ElectricDrives.GenericDrives;
record DriveTestData "Test drive parameters"
  extends GenericDriveData(
    DataName="TestDrive",
    wBase=from_rpm(4500),
    tauNominal=250,
    tauBreakDown=1000,
    tauMax=500,
    T=0.005,
    J=0.1,
    InverterEfficiency=1,
    MotorEfficiency=0.90);
  import Modelica.Units.Conversions.from_rpm;
  annotation(defaultComponentPrefixes="parameter", defaultComponentName="driveData",
    Documentation(info="<html>
<p>Parameters for a generic electric test drive.</p>
</html>"));
end DriveTestData;
