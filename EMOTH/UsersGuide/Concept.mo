within EMOTH.UsersGuide;
class Concept "Description of concepts"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p><img src=\"modelica://EMOTH/Resources/Images/vehicle.png\" align=\"middle\"></p>
<h4>Vehicle structure</h4>
<p>
<ul>
<li><a href=\"modelica://EMOTH.Chassis\">chassis model</a> with dynamic behaviour of the vehicle mass, four wheels with inertia and driving resistances (inclination, rolling resistance and drag)</li>
<li><a href=\"modelica://EMOTH.Brakes\">brake system</a></li>
<li><a href=\"modelica://EMOTH.DriveLines\">drive line model</a> to distribute the motor torque to the wheels in a flexible way</li>
<li><a href=\"modelica://EMOTH.ElectricDrives\">electric drive model</a> with electric machine, current/torque control and power convrter to connect to the dc source/battery</li>
<li><a href=\"modelica://EMOTH.EnergyStorages\">battery model</a></li>
<li><a href=\"modelica://EMOTH.Tracks\">track model</a> defining inclination and rollng resistance coefficient along the track as well as wind speed</li>
<li><a href=\"modelica://EMOTH.Drivers.DriverEnvironment\">driver environment</a> maps signals between the control bus and the driver interface (see below)</li>
</ul>
The throttle and brake signals are provided either 
<ul>
<li>as <a href=\"modelica://EMOTH.Drivers.ThrottleAndBrake\">external signals</a><li>
<li>or by a <a href=\"modelica://EMOTH.Drivers.Driver\">driver model</a>, following a predefined v(t) trajectory given by 
    <a href=\"modelica://EMOTH.Drivers.DrivingCycle\">driving cycle</a> defining the v(t) trajectory as well as a preview<li>
</ul>
The sign of the throttle signal depends on direction of movement (forward/backward), the brake signal is in the range of [0..1]. 
The <a href=\"modelica://EMOTH.Drivers.DriverEnvironment\">driverEnvironment</a>.<a href=\"modelica://EMOTH.Drivers.Components.RecuperationController\">recuperationController</a> 
decides about mechanical braking or recuperation, sending the appropriate signals to the brakes and motor bus.<br>
You may add:
<ul>
<li><a href=\"modelica://EMOTH.Accessories.ElectricalAccessories\">electrical accessories</a> (electrical power consumption, e.g. alternate cooling)</li>
<li><a href=\"modelica://EMOTH.Accessories.RangeExtender\">range extender</a>, i.e. a small engine driving a generator</li>
</ul>
</p>
<h4>Control bus</h4>
<p>
As defined in the <a href=\"modelica://VehicleInterfaces.Interfaces.ControlBus\">Vehicle Interface library</a>, there is a common control bus summarizing sub-busses of the sub-systems to enable the communication between all components. 
The <a href=\"modelica://EMOTH.Drivers.DriverEnvironment\">driver environment</a> maps driver information and control bus signals in both directions.
</p>
<h4>Parameterization</h4>
<p>
Parameter definition can be done by parameter records:
<ul>
<li><a href=\"modelica://EMOTH.ParameterRecords.Vehicles\">vehicle parameters</a> including brake system and driveline</li>
<li><a href=\"modelica://EMOTH.ParameterRecords.ElectricDrives\">electric drive parameters</a></li>
<li><a href=\"modelica://EMOTH.ParameterRecords.EnergyStorages\">battery parameters</a></li>
<li><a href=\"modelica://EMOTH.ParameterRecords.Tracks\">track definitions</a></li>
</ul>
</p>
<h4>Thermal management</h4>
<p>
All components except the chassis have optional thermal connectors to be able to control the distribution of loss power. 
The losses at the chassis (drag and rolling resistance) are located at the surface of the vehicle and are supposed not to be part of the thermal management.
</p>
</ul></html>"));
end Concept;
