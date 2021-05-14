within EMOTH.ParameterRecords.Vehicles;
record VehicleData "Vehicle parameters"
  extends Modelica.Icons.Record;
  constant String DataName="empty" "Name of dataset";
  parameter Modelica.Units.SI.Mass m "Total mass including driver";
  parameter Modelica.Units.SI.Acceleration aNominal "Nominal acceleration";
  parameter Modelica.Units.SI.Velocity vNominal "Nominal speed";
  parameter Modelica.Units.SI.Length Rsub=(rFront + rRear)/2/ratioGear "Substitute wheel radius motor - track";
  parameter Modelica.Units.SI.Mass mDyn=m + 2*(JFront + JRear)/((rFront + rRear)/2)^2 "Substitute (dynamic) mass";
//Brakes
  parameter Real brakeFront=0.5 "Front braking force / total braking force"
    annotation(Dialog(tab="Brakes"));
  parameter Modelica.Units.SI.Force fBrakeFront=m*aNominal*brakeFront
    "Nominal braking force front" annotation (Dialog(tab="Brakes"));
  parameter Modelica.Units.SI.Force fBrakeRear=m*aNominal*(1 - brakeFront)
    "Nominal braking force rear" annotation (Dialog(tab="Brakes"));
  parameter Modelica.Units.SI.Torque tauBrakeFront=fBrakeFront*rFront
    "Nominal braking torque front" annotation (Dialog(
      tab="Brakes",
      group="Result",
      enable=false));
  parameter Modelica.Units.SI.Torque tauBrakeRear=fBrakeRear*rRear
    "Nominal braking torque rear" annotation (Dialog(
      tab="Brakes",
      group="Result",
      enable=false));
//Resistances
  parameter Modelica.Units.SI.Area A "Front area"
    annotation (Dialog(tab="Resistances"));
  parameter Modelica.Units.SI.Density rho=1.18 "Density of air at 25 degC"
    annotation (Dialog(tab="Resistances"));
  parameter Real cw "Drag coefficient"
    annotation(Dialog(tab="Resistances"));
  parameter Modelica.Units.SI.Force Fdrag=rho/2*A*cw*vNominal^2
    "Drag resistance at nominal speed" annotation (Dialog(
      tab="Resistances",
      group="Result",
      enable=false));
//Wheels
  parameter Modelica.Units.SI.Length rFront "Front wheel radius"
    annotation (Dialog(tab="Wheels"));
  parameter Modelica.Units.SI.Inertia JFront "Front wheel inertia"
    annotation (Dialog(tab="Wheels"));
  parameter Modelica.Units.SI.Length rRear "Rear  wheel radius"
    annotation (Dialog(tab="Wheels"));
  parameter Modelica.Units.SI.Inertia JRear "Rear  wheel inertia"
    annotation (Dialog(tab="Wheels"));
//DriveLine
  parameter Real ratioGear "Ratio of gearbox"
    annotation(Dialog(tab="Driveline"));
  parameter Real etaGear "Constant efficiency of gearbox"
    annotation(Dialog(tab="Driveline"));
  parameter Real etaDiff "Constant efficiency of differential"
    annotation(Dialog(tab="Driveline"));
  parameter Modelica.Units.SI.Torque tauDriveNominal=m*aNominal*(rFront + rRear)
      /2/ratioGear "Estimated nominal drive torque" annotation (Dialog(
      tab="Driveline",
      group="Result",
      enable=false));
  parameter Modelica.Units.SI.AngularVelocity wDriveNominal=vNominal/(rFront +
      rRear)*2*ratioGear "Estimated nominal drive speed" annotation (Dialog(
      tab="Driveline",
      group="Result",
      enable=false));
  parameter Modelica.Units.SI.Inertia JVehicle=(m*((rFront + rRear)/2)^2 + 2*(
      JFront + JRear))/ratioGear^2
    "Estimated eqvivalent inertia w.r.t. motor shaft" annotation (Dialog(
      tab="Driveline",
      group="Result",
      enable=false));
  annotation(defaultComponentPrefixes="parameter", defaultComponentName="vehicleData",
    Icon(graphics={Text(
          extent={{-100,-50},{100,-100}},
          lineColor={28,108,200},
          textString="%DataName"), Text(
          extent={{-100,50},{100,0}},
          lineColor={28,108,200},
          textString="vehicle")}),
    Documentation(info="<html>
<p>This parameter record summarizes the parameters of a vehicle.</p>
</html>"));
end VehicleData;
