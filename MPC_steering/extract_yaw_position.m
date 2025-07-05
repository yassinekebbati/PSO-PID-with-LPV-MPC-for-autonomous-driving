[allData, scenario, sensor] = generateSensorData2(); 
tRef = [allData.Time]';

ap = [allData.ActorPoses];



posRef = vertcat(ap.Position);
%velocity = vertcat(ap.Velocity);
%angularvelocity = vertcat(ap.AngularVelocity);

%longitudinal velocity
%vxref = velocity(:,1);

%lateral velocity
%vyref = velocity(:,2);


%yaw rate
%psiref = angularvelocity(:,3);


%xRef = posRef(:,1);
Vx = posRef(:,2);
%yawRef = [ap.Yaw]';


