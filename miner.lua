steps = 9
waitTime = 1
piston_immediate = 0.5
digDownTime = 300
pullUpTime = 50
function piston(side) do
    redstone.setOutput(side, true)
    os.sleep(waitTime)
    redstone.setOutput(side, false)
end

function move(c) do
    print("Moving forward"..c)
    piston("back")
    os.sleep(piston_immediate)
    piston("left")
    os.sleep(waitTime)
end

function dig() do
    print("Start digging")
    redstone.setOutput("front", true)
    os.sleep(dig_down_time)
    print("Retrieving digger")
    redstone.setOutput("front", false)
    os.sleep(pullUpTime)
end

while true do 
    for i=1,steps do
        move(i)
    end
    dig()
end

