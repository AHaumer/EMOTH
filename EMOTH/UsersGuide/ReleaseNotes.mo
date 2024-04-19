within EMOTH.UsersGuide;
class ReleaseNotes "Release notes"

  extends Modelica.Icons.ReleaseNotes;

  annotation (Documentation(info="<html>
<h5>Version 1.0.0, 2016-12-03</h5>
<ul>
<li>Initial release</li>
</ul>
<h5>Version 1.1.0, 2017-06-24</h5>
<ul>
<li>Built-in driving cycles defined in txt-files in EMOTH.Resources.DrivingCycles</li>
<li>Added driving cycles WLTC-class3 and FTP-75</li>
</ul>
<h5>Version 1.2.0, 2017-06-25</h5>
<ul>
<li>Added (linear) battery no-load voltage dependency on SoC</li>
</ul>
<h5>Version 1.3.0, 2017-06-25</h5>
<ul>
<li>Added CADC Common Artemis Driving Cycles (Urban, Rural Road, Motor Highway)</li>
</ul>
<h5>Version 1.4.0, 2017-06-26</h5>
<ul>
<li>Added average energy consumption [kW.h/km]</li>
</ul>
<h5>Version 1.4.1, 2020-03-01</h5>
<ul>
<li>Upgrade to Modelica 3.2.3 and VehicleInterfacs 1.2.5</li>
</ul>
<h5>Version 1.5.0, 2021-04-19</h5>
<ul>
<li>Upgrade to Modelica 4.0.0 and VehicleInterfacs 2.0.0</li>
</ul>
<h5>Version 1.6.0, 2021-05-01</h5>
<ul>
<li>Efficiency map of electric drive</li>
</ul>
<h5>Version 1.7.0, 2021-05-14</h5>
<ul>
<li>Cruise control device</li>
</ul>
<h5>Version 1.8.0, 2021-07-10</h5>
<ul>
<li>ExampleTemplate</li>
<li>Chassis.Car2axle.RollingResistance individual for all 4 wheels</li>
<li>DriveLines.Components.Differential using Modelica.Mechanics.Rotational.Components.IdealPlanetary</li>
</ul>
<h5>Version 1.9.0, 2021-07-11</h5>
<ul>
<li>Removed some unnecessary import statements (EMo)</li>
<li>Started implementation of chassis dynamometer (under construction)</li>
</ul>
<h5>Version 1.9.1, 2024-04-19</h5>
<ul>
<li>Upgraded to VehicleInterfaces 2.0.1</li>
<li>Changed assert to terminate when SoC of battery leaves allowed region</li>
</ul>
<h5>Planned:</h5>
<ul>
<li>Chassis dynamometer</li>
<li>Voltage dependent drive torque limit</li>
</ul>
</html>"));
end ReleaseNotes;
