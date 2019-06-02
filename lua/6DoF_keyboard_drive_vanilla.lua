-- This is a threaded script, and is just an example!
--[[

This script can be used to manually control a six degrees of freedom arm type manipulator (For example: UR10, UR5, etc)
with the keyboard.

Key Mapping:

    t, f -  Joint 1
    y, g - Joint 2
    u, h - Joint 3
    i, j - Joint 4
    o, k - Joint 5 
    p,l  - Joint 6

]]

function sysCall_threadmain()

    sim.setThreadAutomaticSwitch(false) -- disable automatic thread switches
    
    jointHandles={-1,-1,-1,-1,-1,-1}
    for i=1,6,1 do
        jointHandles[i]=sim.getObjectHandle('UR3_joint'..i)
    end

    UR3 = sim.getObjectHandle("UR3")
    UR3_joint1 = sim.getObjectHandle("UR3_joint1")
    UR3_joint2 = sim.getObjectHandle("UR3_joint2")
    UR3_joint3 = sim.getObjectHandle("UR3_joint3")
    UR3_joint4 = sim.getObjectHandle("UR3_joint4")
    UR3_joint5 = sim.getObjectHandle("UR3_joint5")
    UR3_joint6 = sim.getObjectHandle("UR3_joint6")

    -- Set-up some of the RML vectors:
    vel=180
    accel=40
    jerk=80
    currentVel={0,0,0,0,0,0,0}
    currentAccel={0,0,0,0,0,0,0}
    maxVel={vel*math.pi/180,vel*math.pi/180,vel*math.pi/180,vel*math.pi/180,vel*math.pi/180,vel*math.pi/180}
    maxAccel={accel*math.pi/180,accel*math.pi/180,accel*math.pi/180,accel*math.pi/180,accel*math.pi/180,accel*math.pi/180}
    maxJerk={jerk*math.pi/180,jerk*math.pi/180,jerk*math.pi/180,jerk*math.pi/180,jerk*math.pi/180,jerk*math.pi/180}
    targetVel={0,0,0,0,0,0}
    jointRotSpeed = 1*math.pi/180
    targetPos1={0,0,0,0,0,0}

    while sim.getSimulationState() ~= sim.simulation_advancing_abouttostop do
        message,data,data2 = sim.getSimulatorMessage()
        while message~=-1 do
            if (message==sim.message_keypress) then
                if (data[1]==116) then -- t
                    targetPos1[1] = targetPos1[1] + jointRotSpeed
                    -- sim.setJointTargetVelocity(UR3_joint1,targetPos1[1])
                end
                if (data[1]==102) then -- f
                    targetPos1[1] = targetPos1[1] - jointRotSpeed
                    -- sim.setJointTargetVelocity(UR3_joint1,targetPos1[1])
                end
                if (data[1]==121) then -- y
                    targetPos1[2] = targetPos1[2] + jointRotSpeed
                    -- sim.setJointTargetVelocity(UR3_joint2,targetPos1[2])
                end
                if (data[1]==103) then -- g
                    targetPos1[2] = targetPos1[2] - jointRotSpeed
                    -- sim.setJointTargetVelocity(UR3_joint2,targetPos1[2])
                end
                if (data[1]==117) then -- u
                    targetPos1[3] = targetPos1[3] + jointRotSpeed
                    -- sim.setJointTargetVelocity(UR3_joint3,targetPos1[3])
                end
                if (data[1]==104) then -- h
                    targetPos1[3] = targetPos1[3] - jointRotSpeed
                    -- sim.setJointTargetVelocity(UR3_joint3,targetPos1[3])
                end
                if (data[1]==105) then -- i
                    targetPos1[4] = targetPos1[4] + jointRotSpeed
                    -- sim.setJointTargetVelocity(UR3_joint4,targetPos1[4])
                end
                if (data[1]==106) then -- j
                    targetPos1[4] = targetPos1[4] - jointRotSpeed
                    -- sim.setJointTargetVelocity(UR3_joint4,targetPos1[4])
                end
                if (data[1]==111) then -- o
                    targetPos1[5] = targetPos1[5] + jointRotSpeed
                    -- sim.setJointTargetVelocity(UR3_joint5,targetPos1[5])
                end
                if (data[1]==107) then -- k
                    targetPos1[5] = targetPos1[5] - jointRotSpeed
                    -- sim.setJointTargetVelocity(UR3_joint5,targetPos1[5])
                end
                if (data[1]==112) then -- p
                    targetPos1[6] = targetPos1[6] + jointRotSpeed
                    -- sim.setJointTargetVelocity(UR3_joint6,targetPos1[6])
                end
                if (data[1]==108) then -- l
                    targetPos1[6] = targetPos1[6] - jointRotSpeed
                    -- sim.setJointTargetVelocity(UR3_joint6,targetPos1[6])
                end
            end
            message,auxiliaryData=sim.getSimulatorMessage()
        end

     sim.rmlMoveToJointPositions(jointHandles,-1,currentVel,currentAccel,maxVel,maxAccel,maxJerk,targetPos1,targetVel)
     -- Since this script is threaded, don't waste time here:
     sim.switchThread() -- Resume the script at next simulation loop start
    end
end